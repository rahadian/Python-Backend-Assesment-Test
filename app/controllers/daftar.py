from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.orm import joinedload
from app.database import SessionLocal
from app.models.daftar import Daftar as DaftarModel
from app.models.no_rekening import NoRekening as NoRekeningModel
from app.schemas import Daftar as DaftarSchema
from app.schemas import DaftarCreate as DaftarCreateSchema

router = APIRouter()

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

@router.get("/", response_model=List[DaftarSchema])
async def get_daftar(db: Session = Depends(get_db)):
    daftar = db.query(DaftarModel).all()
    # daftar = db.query(DaftarModel).options(joinedload(DaftarModel.no_rekening)).all()
    result = []
    for d in daftar:
        d_dict = d.__dict__
        result.append(d_dict)
    return result

@router.post("/", response_model=DaftarSchema)
async def create_daftar(daftar: DaftarCreateSchema, db: Session = Depends(get_db)):
    if db.query(DaftarModel).filter(DaftarModel.nik == daftar.nik).first():
        raise HTTPException(status_code=400, detail={"remark": "Data nik sudah ada"})
    elif db.query(DaftarModel).filter(DaftarModel.no_hp == daftar.no_hp).first():
        raise HTTPException(status_code=400, detail={"remark": "Data no hp sudah ada"})
    
    db_daftar = DaftarModel(nama=daftar.nama, nik=daftar.nik, no_hp=daftar.no_hp)
    # db_daftar = DaftarModel(**daftar.dict())  
    db.add(db_daftar)
    db.commit()
    db.refresh(db_daftar)

    no_rekening = NoRekeningModel(no_rekening=int(db_daftar.generate_no_rekening()), daftar_id=db_daftar.id)
    db.add(no_rekening)
    db.commit()
    db.refresh(no_rekening)

    response = DaftarSchema(
        id=db_daftar.id,
        nama=db_daftar.nama,
        nik=db_daftar.nik,
        no_hp=db_daftar.no_hp,
        no_rekening=no_rekening.no_rekening,
    )
    return response