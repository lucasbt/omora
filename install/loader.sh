#!/bin/bash

# Loaders
# EMOJIS
emoji_hour=( 0.08 '🕛' '🕐' '🕑' '🕒' '🕓' '🕔' '🕕' '🕖' '🕗' '🕘' '🕙' '🕚')
emoji_earth=( 0.1 🌍 🌎 🌏 )
emoji_moon=( 0.08 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 )
emoji_orange_pulse=( 0.1 🔸 🔶 🟠 🟠 🔶 )
emoji_blue_pulse=( 0.1 🔹 🔷 🔵 🔵 🔷 )
emoji_blink=( 0.06 😐 😐 😐 😐 😐 😐 😐 😐 😐 😑 )
emoji_monkey=( 0.2 🙉 🙈 🙊 🙈 )
# ASCII
line=( 0.08 '☰' '☱' '☳' '☷' '☶' '☴')
breathe=( 0.5 '  ()  ' ' (  ) ' '(    )' ' (  ) ' )
growing=( 0.5 '.  ' '.. ' '...' '.. ' '.  ' '   ' )
passing=( 0.25 '.  ' '.. ' '...' ' ..' '  .' '   ' )
metro=( 0.2 '[    ]' '[=   ]' '[==  ]' '[=== ]' '[ ===]' '[  ==]' '[   =]' )
bounce=( 0.3 '.' '·' '˙' '·' )
bouncing_ball=( 0.4 '(●     )' '( ●    )' '(  ●   )' '(   ●  )' '(    ● )' '(     ●)' '(    ● )' '(   ●  )' '(  ●   )' '( ●    )' )
wave=( 0.1 '𓃉𓃉𓃉' '𓃉𓃉∘' '𓃉∘°' '∘°∘' '°∘𓃉' '∘𓃉𓃉')
classic=( 0.15 '—' "\\" '|' '/' )
dots=( 0.04 '⣾' '⣽' '⣻' '⢿' '⡿' '⣟' '⣯' '⣷' )
dots2=( 0.04 '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏' )
dots3=( 0.04 '⠋' '⠙' '⠚' '⠞' '⠖' '⠦' '⠴' '⠲' '⠳' '⠓' )
dots4=( 0.04 '⠄' '⠆' '⠇' '⠋' '⠙' '⠸' '⠰' '⠠' '⠰' '⠸' '⠙' '⠋' '⠇' '⠆' )
dots5=( 0.04 '⠋' '⠙' '⠚' '⠒' '⠂' '⠂' '⠒' '⠲' '⠴' '⠦' '⠖' '⠒' '⠐' '⠐' '⠒' '⠓' '⠋' )
dots6=( 0.04 '⠁' '⠉' '⠙' '⠚' '⠒' '⠂' '⠂' '⠒' '⠲' '⠴' '⠤' '⠄' '⠄' '⠤' '⠴' '⠲' '⠒' '⠂' '⠂' '⠒' '⠚' '⠙' '⠉' '⠁' )
dots7=( 0.04 '⠈' '⠉' '⠋' '⠓' '⠒' '⠐' '⠐' '⠒' '⠖' '⠦' '⠤' '⠠' '⠠' '⠤' '⠦' '⠖' '⠒' '⠐' '⠐' '⠒' '⠓' '⠋' '⠉' '⠈' )
dots8=( 0.04 '⠁' '⠁' '⠉' '⠙' '⠚' '⠒' '⠂' '⠂' '⠒' '⠲' '⠴' '⠤' '⠄' '⠄' '⠤' '⠠' '⠠' '⠤' '⠦' '⠖' '⠒' '⠐' '⠐' '⠒' '⠓' '⠋' '⠉' '⠈' '⠈' )
dots9=( 0.04  '⢹' '⢺' '⢼' '⣸' '⣇' '⡧' '⡗' '⡏' )
dots10=( 0.04  '⢄' '⢂' '⢁' '⡁' '⡈' '⡐' '⡠' )
dots11=( 0.04 '⠁' '⠂' '⠄' '⡀' '⢀' '⠠' '⠐' '⠈' )

# Função para exibir a animação de carregamento enquanto executa uma outra função
function loader() {
    local func=$2  # Função a ser executada
    local message=$1  # Mensagem personalizada
    local spin_name="dots5"  # Recebe o parâmetro com o delay e os caracteres do spinner
    if [ "$OMORA_DEBUG_MODE" = "true" ]; then
        # Comandos a serem executados se OMORA_DEBUG_MODE for true
        printf "${message}, please wait...\n"
        eval "$func"
        printf "${message} \033[1;32mDone!\033[0m\n"
    else
        # Garantir que o cursor esteja escondido e será restaurado após a execução
        tput civis

        # Primeiro valor do vetor é o delay, o resto são os caracteres do spinner
        spin=$spin_name[@]
        spin=( ${!spin} )
        delay="${spin[0]}"
        unset "spin[0]"
        local i=0

        # Executa a função passada em segundo plano e redireciona toda a saída para /dev/null
        eval "$func" > /dev/null 2>&1 &

        # Pega o PID da função executada
        local pid=$!

        # Desassocia o processo do terminal para evitar mensagens de status do job
        disown $pid

        # Exibe a animação enquanto a função está rodando
        while kill -0 $pid 2>/dev/null; do
            # Modifica o índice para percorrer o array de spin
            printf "\r${message} \033[1;95m${spin[$i]}\033[0m"
            i=$(( (i+1) % ${#spin[@]} ))  # Modifica o índice conforme o tamanho do array
            sleep $delay
        done
        # No final, remove qualquer caractere residual da linha e exibe "Done!"
        printf "\r\033[K${message} \033[1;32mDone!\033[0m\n"  # Limpa o restante da linha com espaços extras
        tput cnorm
    fi
}

# Chama a animação de carregamento enquanto executa a função long_running_task
#loader dots5 "Instalando..." long_running_task
