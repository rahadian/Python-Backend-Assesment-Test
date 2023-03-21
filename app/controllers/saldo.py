from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func, Numeric
from app.database import SessionLocal
from app.models.tabung import Tabung as TabungModel
from app.schemas import Tabung as TabungSchema
from app.schemas import TabungSaldo as TabungSaldoSchema


router = APIRouter()

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

@router.get("/saldo/{no_rekening}", response_model=TabungSaldoSchema)
async def get_saldo(no_rekening: int, db: Session = Depends(get_db)):
    rekening = db.query(TabungModel).filter(TabungModel.no_rekening == no_rekening).first()
    if rekening is None:
        raise HTTPException(status_code=404, detail={"remark": "Data rekening tidak ditemukan"})
    else:
        deposit_total = db.query(func.sum(TabungModel.nominal.cast(Numeric))).filter(TabungModel.no_rekening == no_rekening, TabungModel.status == "C").scalar() or 0
        withdraw_total = db.query(func.sum(TabungModel.nominal.cast(Numeric))).filter(TabungModel.no_rekening == no_rekening, TabungModel.status == "D").scalar() or 0
        saldo = deposit_total - withdraw_total

        response = TabungSaldoSchema(
            no_rekening=no_rekening,
            saldo=saldo,
        )
        return response