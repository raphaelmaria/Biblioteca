import csv
import requests

def enviar_mensagem_whatsapp(nome, numero, apt, torre, vaga_sorteada):
    mensagem = f"Olá {nome}, a vaga de moto {vaga_sorteada} foi atribuida ao apto  {apt} /T {torre} em seu nome e será cobrada no próximo boleto do condominio"