from telegram.ext import Updater, CommandHandler, UpdateQueue

# Função para lidar com o comando /add
def add_movie(bot, update, args):
    # Extrair o título do filme do comando
    movie_title = ' '.join(args)

    # Aqui você pode adicionar a lógica para se comunicar com o Radarr e adicionar o filme à coleção de busca
    # Substitua esta linha com a lógica de integração com o Radarr

    # Responder ao usuário no Telegram
    update.message.reply_text(f"O filme '{movie_title}' foi adicionado à coleção de busca.")

def main():
    # Inicializar o UpdateQueue
    update_queue = UpdateQueue()

    # Inicializar o Updater com o token do bot e a UpdateQueue
    updater = Updater("5022524257:AAGzTqmcXWs40s1k3I8MnsTGkBYVuSAZ4G4", update_queue)

    # Obter o dispatcher para registrar manipuladores
    dp = updater.dispatcher

    # Adicionar um manipulador para o comando /add
    dp.add_handler(CommandHandler("add", add_movie, pass_args=True))

    # Iniciar o bot
    updater.start_polling()

    # Manter o bot em execução
    updater.idle()

if __name__ == '__main__':
    main()
