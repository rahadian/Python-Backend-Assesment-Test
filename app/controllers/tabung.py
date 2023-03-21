import pytz
from typing import List
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func, Numeric
from app.database import SessionLocal
from app.models.tabung import Tabung as TabungModel
from app.models.no_rekening import NoRekening as NoRekeningModel
from app.schemas import Tabung as TabungSchema
from app.schemas import TabungCreate as TabungCreateSchema

tz = pytz.timezone('Asia/Jakarta')
router = APIRouter()

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

@router.get("/", response_model=List[TabungSchema])
async def get_daftar(db: Session = Depends(get_db)):
    tabung = db.query(TabungModel).all()
    return tabung

@router.post("/", response_model=TabungSchema)
async def create_tabung(tabung: TabungCreateSchema, db: Session = Depends(get_db)):
    rekening = db.query(NoRekeningModel).filter(NoRekeningModel.no_rekening == tabung.no_rekening).first()
    if rekening is None:
        raise HTTPException(status_code=400, detail={"remark": "Data rekening tidak ada"})
    else:
        db_tabung = TabungModel(no_rekening=tabung.no_rekening, nominal=tabung.nominal, status="C", waktu=datetime.now(tz)) 
        db.add(db_tabung)
        db.commit()
        db.refresh(db_tabung)

        deposit_total = db.query(func.sum(TabungModel.nominal.cast(Numeric))).filter(TabungModel.no_rekening == tabung.no_rekening, TabungModel.status == "C").scalar() or 0
        withdraw_total = db.query(func.sum(TabungModel.nominal.cast(Numeric))).filter(TabungModel.no_rekening == tabung.no_rekening, TabungModel.status == "D").scalar() or 0
        saldo = deposit_total - withdraw_total

        response = TabungSchema(
            id=db_tabung.id,
            no_rekening=db_tabung.no_rekening,
            nominal=db_tabung.nominal,
            saldo=saldo
        )
        return response