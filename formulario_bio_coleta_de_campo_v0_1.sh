#!/usr/bin/env bash
# formulario_bio_coleta_de_campo_v0_1.sh
#
# 		INFORMAÇÕES
# VERSÃO     : 0.2
# DESCRIÇÃO  : Formulário de coleta de campo de biologia (fitofisionomia+solo).
# DEPENDÊNCIA: dialog
# NASCIMENTO : 11 de Junho de 2015
# AUTORES    : <superantigo (a) gmail.com>
# Copyright 2015 Rodrigo Leite Valentin de Souza <superantigo(a)gmail.com>
# LICENÇA    : GPLv3
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#




#######  FUNÇÃO LOOP/SAIR    ################

loopSair () {
	deNovo=$( dialog --stdout --yesno "Quer executar o programa novamente?" 0 0 )
	case $deNovo in
	0) main ;; # Apertou OK/Yes: roda main() novamente
	1) dialog --infobox "O programa foi fechado." 0 0 && exit 0 ;; # Cancelou.
	# Abaixo: pediu o HELP. extraindo a licença do próprio script.
	2) dialog --title 'HELP' --infobox "$( head -n 28 $0 | tail -n 25 | tr '#' '\n' )" 0 0 ;;
	*) dialog --infobox "Aconteceu algo inesperado. O programa foi fechado." 0 0 ;;
	esac
 }
####### FIM DA FUNÇÃO LOOP/SAIR    ################

main () {
###### Data ########
	dialog \
	--stdout \
	--inputbox 'Digite a data' \
	0 0 \
	'dd/MM/2015' \
	>> DATA.txt
	printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo.

##########fim###############


###### iD ########
 dialog \
--stdout \
--inputbox 'Digite o iD' \
0 0 \
>> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab
#######fim##################


###### Coordenada X ########
dialog \
--stdout \
--inputbox 'Digite a Coordenada X' \
0 0 \
>> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab
##########fim###############

###### Coordenada Y ########
 dialog \
--stdout \
--inputbox 'Digite a Coordenada Y' \
0 0 \
>> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab
#############fim############


###### Classes de Uso e Cobertura do Solo ########
dialog \
 --stdout \
--title 'Classes de Uso e Cobertura do Solo' \
--checklist 'Classes de Uso e Cobertura do Solo' \
0 0 0 \
'Agp' 'Agp' off \
'Cba' 'Cba' off \
'Cbd' 'Cbd' off \
'Cbe' 'Cbe' off \
'Edificações' 'Edificações' off \
'Corpos de água' 'Corpos de água' off \
'S/Info' 'S/Info' off \
>> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab
#########################

####### OBSERVAÇÕES adicionais quanto ao solo ############
 dialog \
--stdout \
--inputbox 'OBSERVAÇÕES quanto ao solo:' \
0 0 \
'Nenhuma' \
>> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab

####################################


#### Principais espécies vegetais#################
 dialog \
 --stdout \
--title 'Seleção dos Componentes' \
--checklist 'Principais espécies vegetais:' \
0 0 0 \
'Algaroba' 'Algaroba' off \
'Angico' 'Angico' off \
'Angico-branco' 'Angico-branco' off \
'Aroeira' 'Aroeira' off \
'Baraúna' 'Baraúna' off \
'Burra-leiteira' 'Burra-leiteira' off \
'Canafístula' 'Canafístula' off \
'Catingueira' 'Catingueira' off \
'Carabeira' 'Carabeira' off \
'Caroá' 'Caroá' off \
'Facheiro' 'Facheiro' off \
'Faveleira' 'Faveleira' off \
'Feijão-bravo' 'Feijão-bravo'  off \
'Imbiritanha' 'Imbiritanha' off \
'Juazeiro' 'Juazeiro' off \
'Jurema branca' 'Jurema branca' off \
'Jurema preta' 'Jurema preta' off \
'Macambira' 'Macambira' off \
'Mandacaru' 'Mandacaru' off \
'Maniçoba' 'Maniçoba'   off \
'Marmeleiro' 'Marmeleiro' off \
'Oiticica' 'Oiticica'   off \
'Pata-de-vaca' 'Pata-de-vaca' off \
'Pau-ferro' 'Pau-ferro'   off \
'Pereiro' 'Pereiro' off \
'Pinhão-manso' 'Pinhão-manso'  off \
'Quebra faca' 'Quebra faca' off \
'Quixabeira' 'Quixabeira' off \
'Rabo-de-raposa' 'Rabo-de-raposa' off \
'Umbuzeiro' 'Umbuzeiro'  off \
'Umburana de cambão' 'Umburana de cambão'   off \
'Umburana de cheiro' 'Umburana de cheiro'  off \
'Xique-xique' 'Xique-xique'   off \
'S/Info' 'S/Info'   off \
 >> DATA.txt
printf '\t'>>DATA.txt # Isso é para dar o espaçamento correto dentro do arquivo. \tab
############################################


#### TIPOS DE SOLO PREDOMINANTE ###############
soloTipo=$( dialog \
 --stdout \
--title 'Tipo de Solo Predominante' \
--checklist 'Tipo de Solo Predominante' \
0 0 0 \
'Solo arenoso' '1' off \
'Franco arenoso' '2' off \
'Com afloramento rochoso' '3' off \
'Com material litólico exposto' '4' off \
'Solo litólico' '5' off \
'Pedregoso' '6' off \
'Solo argiloso' '7' off \
'Presença de serrapilheira' '8' off \
'Latossolo' '9' off \
'S/Info' 'Sem informação' off )
printf " $soloTipo " >> DATA.txt # 

#### A lista acima não abarca "Outros solos". Então: #####
outroSolo=$( dialog \
--stdout \
--inputbox 'Digite os outros tipos de solo:' \
0 0 \
'Nenhum' )
[ $outroSolo!='Nenhum' ] && printf "$outroSolo\t"
	

############################################

######### ALTURA DO DOSSEL  #############

dossel=$( dialog \
--stdout \
--title 'DOSSEL' \
--radiolist 'ALTURA DO DOSSEL:' \
0 0 0 \
'Entre 1 e 2 metros' 'A' on \
'Entre 1 e 3 metros' 'A' off \
'Entre 3 e 5 metros' 'B' off \
'Entre 6 e 8 metros' 'C' off \
'Entre 8 e 10 metros' 'D' off \
 'Herbácea' 'E' off \
'S/Info' 'F' off  )
printf "$dossel\t" >> DATA.txt


###########################################


### OUTRAS CARACTERÍSTICAS #################
 dialog \
--stdout \
--inputbox 'Outras características relevantes:' \
0 0 \
>> DATA.txt
printf '\n' >> DATA.txt # Para a próxima execução do script.

#########################
# Eterno retorno: função loopsair()
loopSair
}
######### FIM DA FUNÇÃO main() ##############



######## CORPO Principal do Script #########
if [ -e DATA.txt ]; then # Verifica se o arquivo existe
	if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
		head -n 28 $0 | tail -n 25 | tr '#' '\n' # Se pedir o HELP na linha de comando, ele lê o cabeçalho e a licença. :3
		exit 0
	else
	[ -r DATA.txt ] && [ -w DATA.txt ] && main || echo "Você não tem permissão de leitura/escrita sobre esse arquivo. Verifique isso, por favor, antes de rodar o script novamente. =S" # Se o arquivo existir, testa se o usuário atual tem permissão de leitura/escrita, se sim, corre a main(). Se não, dá o aviso de que não possui permissão.
	fi
else # Senão, tenta criar o arquivo com esse cabeçalho:
	echo -e "DATA\tX\tY\tiD\tClasses de Uso e Cobertura do Solo\tObservações (quanto ao uso do solo)	\tPrincipais espécies vegetais\tTipo de Solo Predominante\tAltura do dossel\tOutras características relevantes:" >>DATA.txt
	$0 # E chama o próprio script novamente.
fi
exit 0
