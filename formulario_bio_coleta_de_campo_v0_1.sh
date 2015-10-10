#!/usr/bin/env bash
# formulario_bio_coleta_de_campo_v0_9.sh
#
# 			INFORMAÇÕES
# VERSÃO     : 0.9
# DESCRIÇÃO  : Formulário de coleta de campo de biologia (fitofisionomia+solo+usoDosolo).
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
#	-Função loopSair() 
# 0.5 (18 de Junho de 2015):
#	-Corrigido o problema com "Outros solos"
#	-Criada a função outroSolo()
# 0.7 (12 de Agosto de 2015):
#	-Corrigido detalhes de formatação do cabeçalho do arquivo gerado
#	-Inclusão das funções help, info (ainda não funcional) e
#	correção de alguns erros da função loopSair.
# 
# 0.9 (10 de Outubro de 2015)
#   -Adaptaçao as necessidades do cema
#   -Criaçao da funçao arboreas()
#   -Criaçao da funçao comentUso()
#   -Correçao do bug em soloCaract
#   -Acrescimo de especies de plantas herbaceas
#   -Acrescimo de tipos de solos
#


# Variáveis:
# O arquivo que será gerado:
BD=DATA.txt


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
		'q' 'Fechar o programa' off \
		'h' 'Ajuda' off \
		'c' 'Copyright' off )

	case $question in
		y) main ;; 	# roda main() novamente.
		q) dialog --infobox "O programa foi fechado." 0 0 && exit ;; # Fechou.
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
printf "$soloCaract, $outroSolo\t" | sed s/Outros// >> $BD
	
}
#### fim de "Outros solos" ########################################

##### Funçao comentUso #######
comentUso () {
	local comenteUso=$( dialog \
--stdout \
--inputbox 'Digite os outros usos do solo:' \
0 0  )

printf "$uso _ $comenteUso\t" | sed 's/"/ /g' >> $BD
}

#### Funçao Arbóreas #################
arboreas() {
local vegetais=$( dialog \
 --stdout \
--title 'Seleção dos Componentes' \
--checklist 'Arbóreas:' \
0 0 0 \
'Algaroba' 'Algaroba' off \
'Angico' 'Angico' off \
'Angico-branco' 'Angico-branco' off \
'Angico-branco (Piptadenia stipulacea)' 'Angico-branco (2)' off \
'Angico-branco (Parapiptadenia)' 'Angico-branco (3)' off \
'Aroeira' 'Aroeira' off \
'Baraúna' 'Baraúna' off \
'Burra-leiteira' 'Burra-leiteira' off \
'Catingueira' 'Catingueira' off \
'Canafístula' 'Canafístula' off \
'Carabeira' 'Carabeira' off \
'Caroá (Neoglaziavia)' 'Caroá' off \
'Feijão-bravo' 'Feijão-bravo'  off \
'Facheiro' 'Facheiro' off \
'Faveleira' 'Faveleira' off \
'Imbiritanha' 'Imbiritanha' off \
'Juazeiro' 'Juazeiro' off \
'Jurema-branca' 'Jurema branca' off \
'Jurema-preta' 'Jurema preta' off \
'Marmeleiro' 'Marmeleiro' off \
'Macambira' 'Macambira' off \
'Mandacaru' 'Mandacaru' off \
'Maniçoba' 'Maniçoba'   off \
'Oiticica' 'Oiticica'   off \
'Pata-de-vaca' 'Pata-de-vaca' off \
'Pau-ferro' 'Pau-ferro'   off \
'Pereiro' 'Pereiro' off \
'Pinhão-manso' 'Pinhão-manso'  off \
'Quebra-faca' 'Quebra faca' off \
'Quixabeira' 'Quixabeira' off \
'Rabo-de-raposa' 'Rabo-de-raposa' off \
'Umbuzeiro' 'Umbuzeiro'  off \
'Umburana-de-cambão' 'Umburana de cambão'   off \
'Umburana-de-cheiro' 'Umburana de cheiro'  off \
'Xique-xique' 'Xique-xique'   off \
'S/Info' 'S/Info'   off )

# sed tirando espaços e trocando por vírgula+espaço.
printf "$vegetais" | sed 's/ /, /g' >> $BD
printf '\t' >> $BD # Isso é para dar o espaçamento correto dentro do arquivo-> \tab

}
##########Fim da funçao Arbóreas #########

####  Função main()   ########

main () {

###### Data ########
	dialog \
	--stdout \
	--inputbox 'Digite a data' \
	0 0 \
	''\
	>> $BD
	printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo.

########## Fim da Data ###############

############# iD #################
# iD1: pega mas nao escreve ainda; só adiante.
iD1=$( dialog \
--stdout \
--inputbox 'Digite o iD (1)' \
0 0 \
'P ' ) 
#############

### Ponto de Monitoramento. Esse dado é repetido mais à frente.
iD2=$( dialog \
--stdout \
--inputbox 'Digite o Ponto de monitoramento' \
0 0 \
' PML ' ) 

printf "$iD2\t" >> $BD 

# FIm do  Ponto de Monitoramento

# Na ordem correta:
printf "$iD1 $iD2 " >> $BD # 
##############

# iD3=$( dialog \
#--stdout \
#--inputbox 'Digite o iD (3)' \
#0 0 \
#' Cbe ' ) 

dialog \
 --stdout \
--title 'Classes de Uso e Cobertura do Solo' \
--radiolist 'Digite o iD (3º, Classes de Uso e Cobertura do Solo)' \
0 0 0 \
'Agp' 'Agp' off \
'Cba' 'Cba' off \
'Cbd' 'Cbd' off \
'Cbe' 'Cbe' off \
'Nuvem' 'Nuvem' off \
'Sombra' 'Sombra' off \
'Edificações' 'Edificações' off \
'água' 'água' off \
>> $BD
printf "\t" >> $BD # Id3 de Validação

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

# Nesta versao, PARA ADEQUAÇAO AO SISTEMA DO CEMA, nao serah dado o tab abaixo:
# printf '\t'>>$BD # Isso é para dar o espaçamento correto dentro do arquivo. \tab

######## fim da Classes de Uso e Cobertura do Solo #################

####### OBSERVAÇÕES adicionais quanto ao solo ############
# ', ' é para manter a naturalidade dos dados.

uso=$( dialog \
 --stdout \
--title 'OBSERVAÇÕES quanto ao solo:' \
--checklist 'OBSERVAÇÕES quanto a situaçao do terreno:' \
0 0 0 \
', Área de transiçao Cbd.' '1' off \
', Com presença de indivíduos arbóreos.' '2a' off \
', Com presença de indivíduos arbóreos isolados.' '2b' off \
', Com presença de indivíduo arbóreo isolado.' '2d' off \
', Presença de espécies invasoras. ' '2c' off \
', Área de baixada.' '3' off \
', Com drenagem natural.' '3' off \
', Corpos de água.' '3' off \
', Presença de Riacho.'  '4a' off \
', Riacho seco.'  '4b' off \
', Lagoa seca.'  '4c' off \
'Area de fundo de pasto' '5' off \
'Cultivo agrícola.' '6' off \
'Bosque de algaroba. ' '6' off \
', Prática de pecuária.' '7' off \
'Área em regeneraçao natural. Rebrota.' '8' off \
'Área suprimida' '9' off \
'Área de pasto extensivo' '10' off \
'Área em regeneraçao com espécies invasoras.' '11' off \
'Outros' '0' off \
)
# printf $uso | sed 's/"/ /g' >> $BD
# Abaixo: se utilizar a opçao "Outros", chama a funçao comentUso. Senao, imprime no arquivo.
printf $uso | grep -q 'Outros' && comentUso || printf "$uso\t" | sed 's/"/ /g' >> $BD

####### fim de OBSERVAÇÕES adicionais quanto ao solo #############################

# Chamando a funçao arboreas()
arboreas # tive de transformar em funçao. =S

###### fim da funçao arboreas ######################################


#### TIPOS DE SOLO PREDOMINANTE ###############

soloTipo=$( dialog \
 --stdout \
--title 'Tipo de Solo Predominante' \
--checklist 'Tipo de Solo Predominante' \
0 0 0 \
'Solo arenoso' '1' off \
'Solo argiloso' '2' off \
'Solo litólico' '3' off \
'Solo siltoso' '3' off \
'Latossolo' '4' off \
'Franco-arenoso' '5' off \
'Franco-argiloso' '6' off 
'Rocha metamórfica (migmatita)' '7' off )
printf "$soloTipo" | sed 's/"/ /g' >> $BD


# Caracteristicas desse solo:
soloCaract=$( dialog \
 --stdout \
--title 'Paisagem' \
--checklist 'Paisagem:' \
0 0 0 \
'Com afloramento rochoso' 'A' off \
'Presença de serrapilheira' 'D' off \
'Com material litólico exposto' 'B1' off \
'Com material litólico no Horizonte A' 'B4' off \
'Presença de material rochoso no Horizonte A' 'B2' off \
'Presença de Horizonte A' 'L' off \
'Horizonte A litólico' 'B3' off \
'Pedregoso' 'C' off \
'Horizonte A fraco' 'E' off \
'Horizonte A hidromórfico' 'E' off \
'Horizonte A háplico' 'E' off \
'Horizonte A arenoso' 'E' off \
'Presença de erosão' 'F' off \
'Horizonte B háplico' 'G' off \
'Horizonte B Chernozenico' 'G' off \
'Presença de Horizonte R' 'J' off \
'Textura média' 'L' off \
'Pouco profundo' 'K' off \
'Solo raso' 'K' off \
'Sedimentar' 'K' off \
'Relevo ondulado.' '4' off \
'Relevo suave. ' '4' off \
'Relevo suave ondulado.' '4' off \
'Formaçao de riacho.' '10' off \
'Com drenagem natural' '11' off \
'Presença de riacho.' '10' off \
'Outros' '0' off \
'S/Info' 'Sem informação' off )

# Abaixo: descubro se foi selecionado 'Outros'
# e direciono para a função outroSolo()
printf "$soloCaract" | grep -q Outros && outroSolo || printf "$soloCaract\t" | sed 's/"/ /g' >> $BD
###### fim de TIPOS DE SOLO PREDOMINANTE  ###########


######### ALTURA DO DOSSEL #############

dossel=$( dialog \
--stdout \
--title 'DOSSEL' \
--radiolist 'ALTURA DO DOSSEL:' \
0 0 0 \
'Entre 1 e 2 metros'  'A' off \
'Entre 1 e 3 metros'  'B' off \
'Entre 1 e 4 metros'  'C' off \
'Entre 3 e 5 metros'  'D' off \
'Entre 6 e 8 metros'  'E' off \
'Entre 8 e 10 metros' 'E' off \
'S/Info' 'F' off  )
printf "$dossel\t" >> $BD


##### fim de " ALTURA DO DOSSEL" ############################


### OUTRAS CARACTERÍSTICAS #################
## Foto ########


foto=$( dialog \
--stdout \
--title 'DOSSEL' \
--radiolist 'ALTURA DO DOSSEL:' \
0 0 0 \
'A' 'Tem foto'  off \
'B' 'Nao tem foto'  off \
'C' 'Nada' off )

if [ $foto = 'A' ]; then
	local fotoA=$( dialog \
	--stdout \
	--inputbox 'Digite os dados da foto: ' \
	0 0 \
	'Foto: ' )
	printf "$fotoA" >> $BD
elif [ $foto = 'B' ]; then
	printf "Não tem foto. " >> $BD
else
	echo "Pass by"
fi
### fim de Foto ########


#### Atividades no local ##########
# Presença de corte seletivo de madeira.
# Pecuaria extensiva: bovinocultura.
# Presença de cupinzeiros
# Presença de corte raso (broca) com Queimada.
# Relevo ondulado.
# Presença de indivíduos arbóreos: 
# Regeneração natural.
atividades=$( dialog \
 --stdout \
--title 'Diversos' \
--checklist 'Diversos' \
0 0 0 \
'Presença de erosão.' '1' off \
'Presença de corte seletivo de madeira.' '1' off \
'Imbira,' '2' off \
'Presença de caprinos. ' '3' off \
'Presença de suínos. ' '3' off \
'Presença de ovinos. ' '3' off \
'Presença de equinos. ' '3' off \
'Presença de bovinos. ' '3' off \
'Pecuaria extensiva:' '3' off \
' bovinocultura,' '3a' off \
'ovinocultura,' '3b' off \
'caprinocultura,' '3c' off \
'suinocultura,' '3c' off \
'Presença de bovinos.' '3d' off \
'Presença de cupinzeiros.' '4' off \
'Presença de corte raso (broca) com Queimada.' '5' off \
'Regeneração natural.' '5' off \
'Presença de indivíduos arbóreos isolados: ' '6a' off \
'Presença de indivíduos arbóreos: ' '6b' off \
'Presença de culturas oleiriculas.' '7' off \
'Presença de culturas de curto ciclo.' '8' off \
'Presença de cultura de árvores frutíferas.' '9' off \
'Supressao de área de APP' '10' off \
'Área degradada com corte de arbóreas.' '11' off \
'Área de regeneração.' '12' off \
'Extrato herbáceo de até 80cm.' '13a' off \
'Sem extrato herbáceo.' '13b' off \
'Com edificaçoes' '14' off \
'Presença de especie exotica: ' '0' off )
#####
printf "$atividades" | sed 's/"/ /g' >> $BD
 dialog \
--stdout \
--inputbox 'Digite os indivíduos arbóreos:' \
0 0 \
>> $BD
####FIM de  Atividades no local ##########

#####################Plantas adicionais ##########
extrHerb=$( dialog \
 --stdout \
 --title 'Plantas adicionais' \
 --checklist 'Plantas adicionais' \
 0 0 0 \
 'Portulaca elatio,' '1' off \
 'Imbira,' '2' off \
 'Cansanção,' '3' off \
 'Sida sp,' '4' off \
 'Sida galheirensis,' '4a' off \
 'Sida (flor branca),' '4b' off \
 'Sida (flor amarela),' '4c' off \
 'Pau-branco,' '5' off \
 'Melochia tomentosa,' '6' off \
 'Tacinga sp,' '7a' off \
 'Tacinga inamoema,' '7c' off \
 'Tacinga palmadora,' '7b' off \
 'Croton sp,' '8a' off \
 'Croton blanchethianus (marmeleiro),' '8b' off \
 'Croton rahmnifolioides,' '8c' off \
 'Croton sonderianus,' '8d' off \
 'Moleque-duro,' '9a' off \
 'Maytenus rigida,' '9b' off \
 'Helicteres sp,' '10' off \
 'Tilandsia loliadae,' '11' off \
 'Milocactus,' '12a' off \
 'Milocactus zehntneri,' '12b' off \
 'Cnidoscolus bahiensis,' '13a' off \
 'Cnidoscolus urens,' '13b' off \
 'Cnidoscolus bahianus,' '13c' off \
 'Cissus decidua,' '14' off \
 'Herissantia crispa,' '15' off \
 'Canafístula,' '16' off \
 'Varronia globosa,' '17' off \
 'Parapiptadenia zehntneri,' '18a' off \
 'Parapiptadenia sp,' '18b' off \
 'Piptadenia stipulacea,' '18c' off \
 'Piptadenia sp,' '18d' off \
 'Fraunhophera,' '19a' off \
 'Fraunhophera multiflora,' '19b' off \
 'Serjania glabrata,' '20' off \
 'Cynophalla hastata' '21' off \
 'Ipe-roxo,' '22' off \
 'Neocalyptrocalyx longifolium,' '23' off \
 'Handroanthus spongiosus,' '23' off \
 'Gramíneas,' '24' off \
 'Caparis,' '25' off \
 'Prosopis juliflora (Algaroba),' '26' off \
 'Juazeiro (Ziziphus joazeiro),' '27' off \
 'Calatuapsis,' '28' off \
 'Ruellia asperula,' '29a' off \
 'Ruellia sp,' '29b' off \
 'Sp1.' '30' off \
 'Jurema' '31' off \
 'Riodella teres' '32' off \
 'Bromélia Karatas' '33' off \
 'Calotropis sp' '34' off \
 'Nicotiana sp' '35' off \
 'Pyterocarpa,' '36' off \
 'Algodao,' '37' off \
 'Triplaris gardneriana,' '36' off \
 'Senna espectabilis,' '37' off \
 'Dalbergia cearensis,' '38' off \
 'Carnaúba,' '39' off \
 'Trischidium sp,' '40' off \
 'Palmadora,' '41' off \
 'Macambira,' '42' off \
 'Quipá,' '43' off \
 'Jatuapha mutabilis' '44' off \
 'Poincianella mycrophio' '45a' off \
 'Poincianella sp' '45b' off \
 'Bromélia laciniosa,' '46' off \
 'Jatropha ribifolia' '44' off \
 'J. molissima' '47' off \
 'Pavonia, ' '48' off \
 'Pithecellobium diversifolium, ' '49' off \
 'V. leucochephala.' '50' off \
 'Calliandra, ' '50' off \
 'Arrojadoa, ' '50' off \
 'Erythroxylum pugens, ' '51' off \
 'Mimosa aphtalmocentra, ' '51' off \
 'Barriguda, ' '53' off \
 'Senegalia tenuiflora,' '52' off \
 'Sem extrato herbáceo' '0' off )
  
if [ $( echo $extrHerb | wc -m ) -gt 2 ]; then
	printf "$extrHerb" |  sed 's/"//g' >> $BD
#	printf "Extrato herbáceo: $extrHerb" |  sed 's/"//g' >> $BD
fi
# Sem tab extra, porque entra como "Outras caracteristicas"
####################Fim do Extrato herbaceo ####################

###############
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

if [ -z $question ]; then
	main
else
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
fi
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
