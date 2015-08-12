#!/usr/bin/env bash
# formulario_bio_coleta_de_campo_v0_5.sh
#
# 			INFORMAÇÕES
# VERSÃO     : 0.5
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
######################################################################
#
# CHANGELOG
#
# 0.2 (11 de Junho de 2015):
#	-Criação do esqueleto básico do programa
#	-Função loopSair() (auto-explicativo... ;) )
# 0.5 (18 de Junho de 2015):
#	-Corrigido o problema com "Outros solos"
#	-Criada a função outroSolo()
# 1.0 (12 de Agosto de 2015):
#	-Corrigido detalhes de formatação do cabeçalho do arquivo gerado
#	-Inclusão das funções help, info (ainda não funcional) e
#	correção de alguns erros da função loopSair.

# Variáveis:
# O arquivo que será gerado:
BD=DATA.csv


####### FUNÇÃO HELP  #############
help() {
	
	echo "Uso: $0 [OPÇÃO]"
	echo "Formulário de campo para biólogos usando dialog."
	echo ""
	exit 0
}
######## FIM DA FUNÇÃO HELP ###########


######## FUNÇÃO INFO ###########
info() {
	 clear; sed -n '/INFORMAÇÕES/{:a;/GPLv3/!{N;ba;};p;}' $0 | tr -d '#' | fmt -s
	 sed -n "/CHANGELOG/{:a;/Variáveis/!{N;ba;};p;}" $0 | tr -d '#' | fmt -s
	 exit 0
	 }
######## FIM DA FUNÇÃO INFO ###########


#######  FUNÇÃO LOOP/SAIR    ################

loopSair () {
	question=$( dialog \
		--stdout \
		--title 'Reiniciar/Fechar/Ajuda/Copyright' \
		--radiolist 'O que você deseja fazer agora?' \
		0 0 0 \
		'y' 'Rodar o programa novamente' off \
		'n' 'Fechar o programa' off \
		'h' 'Ajuda' off \
		'c' 'Copyright' off )

	case $question in
	y) main ;; 	# roda main() novamente.
	n) dialog --infobox "O programa foi fechado." 0 0 ;; # Fechou.
	h) help ;; # chama help (a ser escrito)
	c) copyright ;; # chama a função copyright e chama o loopSair
	*) dialog --infobox "Ocorreu algo inesperado. O programa foi fechado." 0 0 ;;
	esac
}




####### FIM DA FUNÇÃO LOOP/SAIR    ################

####### 	FUNÇÃO COPYRIGHT	    ################
copyright() {
	clear
	# lê o cabeçalho e a licença. :3
	sed -n '/INFORMAÇÕES/{:a;/02110-1301/!{N;ba;};p;}' $0 | tr -d '#' | fmt -s

	exit 0
}
####### FIM DA FUNÇÃO COPYRIGHT    ################

###### Função outroSolo()  ####################
#### A lista de solos não compreende todos os solos. Então:
outroSolo() {
outroSolo=$( dialog \
--stdout \
--inputbox 'Digite os outros tipos de solo:' \
0 0 \ )
# Abaixo: limpo a variável $soloTipo com sed s'ubstitui antes de escrever no arq.
printf "$soloTipo $outroSolo\t" | sed s/Outros/""/ >> $BD
	
}
#### fim de "Outros solos" ########################################


####  Função main()   ########

main () {

###### Data ########
	dialog \
	--stdout \
	--inputbox 'Digite a data' \
	0 0 \
	'//2015' \
	>> $BD
	printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo.

########## Fim da Data ###############


############# iD #################
 dialog \
--stdout \
--inputbox 'Digite o iD' \
0 0 \
>> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab
####### fim do iD ##################


###### Coordenada X ########
dialog \
--stdout \
--inputbox 'Digite a Coordenada X' \
0 0 \
>> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab
##########fim da Coordenada X ###############

###### Coordenada Y ########
 dialog \
--stdout \
--inputbox 'Digite a Coordenada Y' \
0 0 \
>> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab
#############fim da Coordenada Y ############


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
>> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab
######## fim da Classes de Uso e Cobertura do Solo #################

####### OBSERVAÇÕES adicionais quanto ao solo ############
 dialog \
--stdout \
--inputbox 'OBSERVAÇÕES quanto ao solo:' \
0 0 \
'Nenhuma' \
>> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab

####### fim de OBSERVAÇÕES adicionais quanto ao solo #############################


#### Principais espécies vegetais #################
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
 >> $BD
printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo-> \tab
###### fim de Principais espécies vegetais ######################################


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
'Outros' '10' off \
'S/Info' 'Sem informação' off )

# Abaixo: descubro se foi selecionado 'Outros'
# e direciono para a função outroSolo()
echo $soloTipo | grep -q Outros && outroSolo || printf "$soloTipo\t" >> $BD


###### fim de TIPOS DE SOLO PREDOMINANTE  ###########


######### ALTURA DO DOSSEL #############

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
printf "$dossel\t" >> $BD


##### fim de " ALTURA DO DOSSEL" ############################


### OUTRAS CARACTERÍSTICAS #################
 dialog \
--stdout \
--inputbox 'Outras características relevantes:' \
0 0 \
>> $BD
printf '\n' >> $BD # Para a próxima execução do script.

#### fim de "OUTRAS CARACTERÍSTICAS" #####################


#### Eterno retorno: função loopsair() ######
loopSair
}
######### FIM DA FUNÇÃO main() ##############



######## CORPO do Script #########

# VERIFICAÇÃO DE DEPENDÊNCIAS
# Verifica se o sistema tem o dialog instalado. Futuramente posso usar isso prá criar uma variável:
which dialog && echo "OK! dialog instalado!" || echo "Este programa depende do programa \
dialog estar instalado, e parece não estar. Instale ou contacte o administrador do sistema." # && exit 0


case $1 in
	-h)				help ;; # chama help (a ser escrito)
	--help) 		help ;; # chama help (a ser escrito)
	-c)				copyright ;; # chama a função copyright e chama o loopSair
	--copyright)	copyright ;; # chama a função copyright e chama o loopSair

	# Abaixo: alquimia prá obter os dados atuais do script.
	-i)				info ;;
	--info)				info ;;
	*) echo "Opção desconhecida" && exit 0 ;;
esac
# Verifica se foi dado argumento --help ou -h na linha de comando:
#if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
#	help
#	exit 0
#fi

if [ -e $BD ]; then # Verifica se o arquivo existe

	[ -r $BD ] && [ -w $BD ] && main || echo "Você não tem permissão\
	de leitura/escrita sobre esse arquivo. Verifique isso, por favor, antes de\
	rodar o script novamente. =S" # Se o arquivo existir, testa se o usuário
	# atual tem permissão de leitura/escrita, se sim, corre a main(). Se não,
	# dá o aviso de que não possui permissão.

else # Senão, tenta criar o arquivo com esse cabeçalho:
	echo -e "DATA\tiD\tX\tY\tClasses de Uso e Cobertura do Solo\tObservações (quanto ao uso do solo)\t Principais espécies vegetais\t Tipo de Solo Predominante\tAltura do dossel\tOutras características relevantes:" >> $BD
	$0 # E chama o próprio script.
fi
exit 0
