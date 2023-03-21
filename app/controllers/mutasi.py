from typing import List
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func, Numeric
from app.database import SessionLocal
from app.models.tabung import Tabung as TabungModel
from app.schemas import Mutasi as MutasiSchema


router = APIRouter()

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

@router.get("/mutasi/{no_rekening}", response_model=List[MutasiSchema])
async def get_mutasi(no_rekening: int, db: Session = Depends(get_db)):
    rekening = db.query(TabungModel).filter(TabungModel.no_rekening == no_rekening).first()
    if rekening is None:
        raise HTTPException(status_code=404, detail={"remark": "Data rekening tidak ditemukan"})
    
    mutasi = db.query(TabungModel).filter(TabungModel.no_rekening == no_rekening).all()
    return mutasi