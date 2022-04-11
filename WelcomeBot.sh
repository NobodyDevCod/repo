#!/bin/bash

# script: WelcomeBot.sh
#
# Para melhor compreensão foram utilizados parâmetros longos nas funções; Podendo
# ser substituidos pelos parâmetros curtos respectivos.

# Importando API
source ShellBot.sh

# Token do bot
bot_token='5292878177:AAFn5VAyH3KQ5dzpFQWa2pfhpMSD1SsaxYc'

# Inicializando o bot
ShellBot.init --token "$bot_token"
ShellBot.username

# info dos loti
info_loti()
{
	local msg

	# Texto da mensagem
            msg+="😏 INFO DOS LOTI 😳"
    msg+="---------------------------------------------------------"'\n'

    msg+="ID DO LOTI: *${message_from_id[$id]}*"'\n'
    msg+="NOME DO LOTI: *${message_from_first_name[$id]}*"'\n'
    msg+="USERNAME DO LOTI: *@${message_from_username[$id]}*"'\n'
    msg+="USUARIO DE TORRENT: $((($RANDOM %100) + 1))%"'\n'
    msg+="---------------------------------------------------------"'\n'

	# Envia a mensagem de boas vindas.
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action 'typing'
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        							--text "$(echo -e $msg)" \
            							--parse_mode markdown

	return 0	
}


# boas vindas
start()
{
	local msg

	# Texto da mensagem
    msg+="😳😏 OPA BEM VINDO 😳😏"
    msg+="---------------------------------------------------------"'\n'

    msg+="COMANDOS /lotis /senha"'\n'
    msg+="CRIADOR: @NobodyDev 😏"'\n'

    msg+="---------------------------------------------------------"'\n'
	# Envia a mensagem de boas vindas.
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action 'typing'
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown

	return 0	
}


senha()
{
        local msg
    msg+="😏GERADOR DE SENHA (BETA)😳"'\n'
    msg+="---------------------------------------------------------"'\n'
    msg+="SUA SENHA: $((($RANDOM %99999999) + 999999999))"'\n'
    msg+="---------------------------------------------------------"'\n'

	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action 'typing'
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown

	return 0	
}


while :
do
	# Obtem as atualizações
	ShellBot.getUpdates --limit 999 --offset $(ShellBot.OffsetNext) --timeout 999
	
	# 'Lista o índice das atualizações
	for id in $(ShellBot.ListUpdates)
	do
	# Inicio thread
	(

		# Verifica sea mensagem efnviada pelo usuário é um comando válido.
		case ${message_text[$id]} in
                        '/lotis') info_loti;;
                        '/start') start;;
                        '/senha') senha;;
                esac
	) & # Utilize a thread se deseja que o bot responda a várias requisições simultâneas.
	done
done
#FIM

