from pydantic import BaseModel, validator
from typing import Optional
from datetime import datetime
from dateutil.parser import parse

class DaftarBase(BaseModel):
    nama: str
    nik: str
    no_hp: str

class DaftarCreate(DaftarBase):
    nama: str
    nik: str
    no_hp: str

    class Config:
        orm_mode = True
        use_enum_values = True
        # exclude the id field from the request body
        orm_exclude = ["id"]

class Daftar(DaftarBase):
    id: int

    class Config:
        orm_mode = True

class TabungBase(BaseModel):
    no_rekening: int
    nominal: str

class TabungCreate(TabungBase):
    no_rekening: int
    nominal: str
    # status: str

    class Config:
        orm_mode = True
        use_enum_values = True
        # exclude the id field from the request body
        orm_exclude = ["id"]

class Tabung(TabungBase):
    id: int
    
    class Config:
        orm_mode = True

class TabungSaldo(BaseModel):
    no_rekening: int
    saldo: float

class MutasiBase(BaseModel):
    no_rekening: int
    nominal: float
    status: str
    waktu: datetime

class Mutasi(MutasiBase):
    no_rekening: Optional[int] = None
    nominal: Optional[float] = None
    status: Optional[str] = None
    waktu: Optional[datetime] = None

    @validator('waktu', pre=True, always=True)
    def parse_waktu(cls, value):
        if isinstance(value, datetime):
            return parse_date(value.strftime("%Y-%m-%d %H:%M:%S"))
        return parse_date(value)

    class Config:
        orm_mode = True

def parse_date(date_str: str):
    return datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")