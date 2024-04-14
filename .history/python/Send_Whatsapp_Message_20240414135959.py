import csv
import requests

def enviar_mensagem_whatsapp(nome, numero, apt, torre, vaga_sorteada):
    mensagem = f""