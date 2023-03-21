# from fastapi import FastAPI
# import psycopg2
import pytz
from fastapi import FastAPI
from app.controllers.daftar import router as routerdaftar
from app.controllers.tabung import router as routertabung
from app.controllers.tarik import router as routertarik
from app.controllers.saldo import router as routersaldo
from app.controllers.mutasi import router as routermutasi
from app.database import create_all_tables, get_db
# from app.models.daftar import Daftar

app = FastAPI()
create_all_tables()

@app.get("/")
async def read_root():
    return {"Hello": "World"}

app.include_router(routerdaftar, prefix="/daftar", tags=["daftar"])
app.include_router(routertabung, prefix="/tabung", tags=["tabung"])
app.include_router(routertarik, prefix="/tarik", tags=["tarik"])
app.include_router(routersaldo, prefix="/saldo", tags=["saldo"])
app.include_router(routermutasi, prefix="/mutasi", tags=["mutasi"])
