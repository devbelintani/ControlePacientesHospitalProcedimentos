
create database hospital_db;

use hospital_db;

create table convenio
(
id_convenio int not null auto_increment,
nome_convenio varchar(45) not null,
cnpj char(14) not null,
carencia varchar(45) not null,
primary key (id_convenio)
);

create table paciente
(
id_paciente int not null auto_increment,
nome varchar(100) not null,
data_nasc date not null,
endereco varchar(255) not null,
telefone varchar(13) not null,
email varchar(45) not null,
cpf char(12) not null,
rg varchar(12) not null,
convenio_id int,
primary key (id_paciente),
foreign key (convenio_id) references convenio (id_convenio)
);

create table especialidade
(
id_especialidade int not null auto_increment,
descricao_especialidade varchar(255) not null,
primary key (id_especialidade)
);

CREATE TABLE medico 
(
id_medico int not null auto_increment,
nome varchar(100) not null,
crm varchar(15) not null,
uf_crm varchar(2) not null,
data_nasc date not null,
endereco varchar(255) not null,
telefone varchar(13) not null,
email varchar(45) not null,
cpf char(12) not null,
rg char(12) not null,
primary key (id_medico)
);

create table medico_especialidade
(
id_medico int not null,
id_especialidade int not null,
primary key (id_medico, id_especialidade),
foreign key (id_medico) references medico (id_medico),
foreign key (id_especialidade) references especialidade (id_especialidade)
);

create table tipo_quarto
(
id_tipo_quarto int,
descricao varchar(255) not null,
valor_diaria decimal(10,2) not null,
primary key (id_tipo_quarto)
);

create table quarto
(
id_quarto int not null,
numero varchar(4) not null,
id_tipo_quarto int,
primary key (id_quarto),
foreign key (id_tipo_quarto) references tipo_quarto (id_tipo_quarto)
);

create table enfermeiro
(
id_enfermeiro int not null auto_increment,
nome varchar(100) not null,
cpf varchar(11) not null,
cre varchar(6) not null,
primary key (id_enfermeiro)
);

create table internacao
(
id_internacao int not null auto_increment,
data_entrada date not null,
data_prev_alta date,
data_alta date,
procedimento varchar(255) not null,
medico_id_medico int,
paciente_id_paciente int,
quarto_id_quarto int,
primary key (id_internacao),
foreign key (medico_id_medico) references medico (id_medico),
foreign key (paciente_id_paciente) references paciente (id_paciente),
foreign key (quarto_id_quarto) references quarto (id_quarto)
);

create table enfermeiro_internacao
(
id_enfermeiro int,
id_internacao int,
primary key (id_enfermeiro, id_internacao),
foreign key (id_enfermeiro) references enfermeiro (id_enfermeiro),
foreign key (id_internacao) references internacao (id_internacao)
);

create table consulta
(
id_consulta int not null auto_increment,
data_consulta date not null,
hora time not null,
valor_consulta decimal(10,2) not null,
carteirinha varchar(20),
id_medico int,
id_paciente int,
id_convenio int,
id_especialidade int,
primary key (id_consulta),
foreign key (id_medico) references medico (id_medico),
foreign key (id_paciente) references paciente (id_paciente),
foreign key (id_convenio) references convenio (id_convenio),
foreign key (id_especialidade) references especialidade (id_especialidade)
);

CREATE TABLE receita
(
	id_receita INT NOT NULL AUTO_INCREMENT,
	data_receita DATE,
	remedio1 VARCHAR(100),
    posologia1 VARCHAR(255),
	remedio2 VARCHAR(100),
    posologia2 VARCHAR(255),
	remedio3 VARCHAR(100),
    posologia3 VARCHAR(255),
	remedio4 VARCHAR(100),
    posologia4 VARCHAR(255),
	id_consulta INT NOT NULL,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
	PRIMARY KEY (id_receita),
	FOREIGN KEY (id_consulta) REFERENCES consulta (id_consulta),
	FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
	FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
 	);


INSERT INTO convenio (id_convenio, nome_convenio, cnpj, carencia) 
	VALUES 	(1,'MedMais', 87818227000127, '60 dias');
	INSERT INTO convenio (nome_convenio, cnpj, carencia) 
	VALUES 	('UniSaude', 30007500000116, '60 dias'),
			('Pro Health', 11929240000191, '90 dias'),
			('Santa Casa', 16905113000176, '120 dias'),
			('Bradesco Saude', 82652051000162, '120 dias'),
			('Unimed', 87683742000147, '180 dias'),
			('Porto Seguro', 33287197000140, '90 dias'),
			('Cassi', 72661334000117, '120 dias')
	;
		
INSERT INTO paciente (id_paciente, nome, data_nasc, endereco, telefone, email, cpf, rg, convenio_id)
	VALUES	(1,'Armindo Moreira Azeredo', '1978-01-15', 'Rua Mário Amaral, 215 - Bairro Paraíso / SP - CEP 04002020', 11996732902, 'armindoma@plastic.com.br', '72633324851', '364411533', 1);
	INSERT INTO paciente (nome, data_nasc, endereco, telefone, email, cpf, rg, convenio_id)
	VALUES	('Cármen Mata Camargo', '1993-01-22',	'Rua Iacaia, 713 - Bairro: Imirim / SP - CEP 02467002', 11998482737, 'carmem@unianhanguera.edu.br', '76039129891', 448714188, 3),
			('Cármen Mata Camargo', '1993-01-22',	'Rua Iacaia, 713 - Bairro: Imirim / SP - CEP 02467002', 11998482737, 'carmem@unianhanguera.edu.br', '76039129891', 448714188, 1),
			('César Sítima Faria', '1993-03-01', 'Rua PAssagem Seis, 921 - Bairro: Jardim Dracena / SP - CEP 05528340', 11984474899, 'sitima@jp.ind.br', '90510059899', 336892056, null),
			('Evandro Trindade Bouça', '1993-11-25', 'Rua Anibal Fazzani, 929 - Bairro: Vila Matias /SP - CEP 02039040', 11996312380, 'etrindade@carvajal.com', '23462841815', 507187179, null),
			('Fabrício Norões Xavier', '1993-02-14', 'Travessa Alfonso Renaldo Galluci, 179 - Bairro: Jardim das Laranjeiras / SP - CEP 02517120', 11984118995, 'fabricion@maxilajes.com.br', '07897387836', 233561699, 1),
			('Fabrício Norões Xavier', '1993-02-14', 'Travessa Alfonso Renaldo Galluci, 179 - Bairro: Jardim das Laranjeiras / SP - CEP 02517120', 11984118995, 'fabricion@maxilajes.com.br', '07897387836', 233561699, 2),
			('Fabrício Norões Xavier', '1993-02-14', 'Travessa Alfonso Renaldo Galluci, 179 - Bairro: Jardim das Laranjeiras / SP - CEP 02517120', 11984118995, 'fabricion@maxilajes.com.br', '07897387836', 233561699, null),			
			('Francisca Parracho Caneira', '1987-07-09', 'Rua Arapari, 318 - Bairro: Jardim Textil / SP - CEP 03415020', '11999685030', 'fran@tecsysbrasil.com.br', '44197160887', 273763350, 2),
			('Giovanni Arouca Mata', '1988-09-09', 'Travessa Pedro José Rocha, 460 - Bairro: Jardim Brasil / SP - CEP 02226030', '11993197256', 'giarouca@peopleside.com.br', '93581511886', 331672066, null),
			('Helton Espinosa', '1999-02-11', 'Rua Cabinda, 981 - Bairro: Vila Lúcia / SP - CEP: 03144040', '1135218527', 'hespi@gmaill.com', '04246267805', 125093792, 2),
			('Ivo Brandão Palos', '1993-08-10', 'Travessa Florencio Estrella, 299 - Bairro: Santana / SP - CEP 02033025', '1135251634', 'ivobp@eanac.com.br', '00700559809', 184962900, 3),
			('Karine Macena Porciúncula', '1984-11-18', 'Rua Canto da Tarde, 262 - Bairro: Conjunto Residencial José Bonifácio / SP - CEP 08253460', '11983507649', 'karine@salera.com.br', '34773073802', 341333608, 2),
			('Karine Macena Porciúncula', '1984-11-18', 'Rua Canto da Tarde, 262 - Bairro: Conjunto Residencial José Bonifácio / SP - CEP 08253460', '11983507649', 'karine@salera.com.br', '34773073802', 341333608, null),
			('Mark Festas Santana', '2007-06-19', 'Rua Albano José Coelho, 821 - Bairro: Jaçanã / SP - CEP 02276150', '1139168632', 'markf@clinicasilhouette.com.br', '65283884821', 234368676, 2),
			('Mark Festas Santana', '2007-06-19', 'Rua Albano José Coelho, 821 - Bairro: Jaçanã / SP - CEP 02276150', '1139168632', 'markf@clinicasilhouette.com.br', '65283884821', 234368676, null),
			('Pablo Atilano Flores', '1979-04-05', 'Rua Dois Corregos, 196 - Bairro: Vila Bertioga / SP - CEP 03181020', '11986172235', 'pabloatilano@zipmail.com', '53759118844', 456282014, 2),
			('Silvana Fartaria Nazário', '1993-06-21', 'Rua São Jorge, 566 - Bairro: Chacara Gaivotas / SP - CEP 04849327', '11982230233', 'silvana@casabellavidros.com.br', '12431158829', 424229080, 3),
			('Silvana Fartaria Nazário', '1993-06-21', 'Rua São Jorge, 566 - Bairro: Chacara Gaivotas / SP - CEP 04849327', '11982230233', 'silvana@casabellavidros.com.br', '12431158829', 424229080, null),
			('Zilda Gomide Osório', '1982-06-22', 'Rua Antônio Francisco Rosa, 644 - Bairro: Jardim Edda / SP - CEP 04844040', '1135314964', 'zilda@performa.com.br', '70423108883', 475018266, 1),
			('Zilda Gomide Osório', '1982-06-22', 'Rua Antônio Francisco Rosa, 644 - Bairro: Jardim Edda / SP - CEP 04844040', '1135314964', 'zilda@performa.com.br', '70423108883', 475018266, null),
			('Carlos Afonso', '2015-03-15', 'Rua Charles Muller, 345 - Bairro: Jardim Dalva / SP - CEP 02567890', '1132659745', 'cafonso@gmail.com', '35954622563', 322456232, 4),
			('Elvis Costelo', '1965-03-29', 'Rua Dracena, 326 - Bairro: Colosso / SP - CEP 12328340', '1135668945', 'naotem@naotem.com.br', '32693824471', 328654125, 5),
			('Claudia Abgail', '1958-05-24', 'Rua Albertino de Almeida, 658 - Bairro Centro / SP - CEP 15329456', '1135965478', 'claudiaab@gmail.com', '45685236671', 652432851, 6),
			('James Dean', '1959-07-26', 'Rua Antonio Afonso, 8756 - Bairro Colonial / SP - CEP 32456985', '11991915536', 'jadean@yahoo.com', '65986459912', 653248423, 7),
			('Julia Galdot', '1999-02-23', 'Rua Paixões, 365 - Bairro: Albuquerque / SP - CEP 36254983', '1136952874', 'galdotj@gmail.com', '28263958841', 324856952, 8)
		;


INSERT INTO especialidade (id_especialidade, descricao_especialidade) 
	VALUES 	(1, 'Dermatologista'),
			(2, 'Gastroenterologia'),
			(3, 'Clínico Geral'),
			(4, 'Pediatria'),
			(5, 'Pediatra'),
			(6, 'Cardiologista'),
			(7, 'Endocrinologista')
		;
		
INSERT INTO medico (id_medico, nome, crm, uf_crm, data_nasc, endereco, telefone, email, cpf, rg)
	VALUES	(1, 'Gael Milheiro Lemes', '32564','SP', '1955-12-15', 'Rua Afonso Pena, 3256 - Bairro Centro / SP - CEP 02536325', '11663599632', 'gaelmi@gmail.com', '63596375981', 652372531),
			(2, 'Cristovão Xavier', '35668', 'SP', '1965-11-21', 'Rua Abilio Cardoso, 453 - Bairro Aquarius / SP - CEP 02356649', '1139556648', 'xavier@gmail.com', '28269485517', 325688592),
			(3, 'Alisson Sacramento', '45622', 'SP', '1975-05-24', 'Avenida Cardoso Silva, 4563 - Bairro Alpina / SP - CEP 12350985', '11988542466', 'gomide@yahoo.com', '32567491185', 564759582),
			(4, 'Júlia Camarinho', '39558', 'SP', '1979-12-11', 'Avenida Barbacena, 956 - Bairro Satélite / SP - CEP 02546325', '11982554675', 'camarinho@outlook.com', '95645236671', 985642135),
			(5, 'Lívia Veloso', '41652', 'SP', '1980-06-21', 'Avenida Francisco Paes, 655 - Bairro Centro / SP - CEP 23452652', '11324555782', 'lveloso@cardio.com.br', '26485697741', 125465231),
			(6, 'Suéli Simão Pegado', '40665', 'GO', '1979-02-21', 'Rua Alberto Norteman, 5469 - Bairro Centro / SP - CEP 12453985', '11954856485', 'pegado@fisio.com.br', '54542896551', 244563821),
			(7, 'Tito Caruqeijeiro', '43526', 'ES', '1980-07-22', 'Rua Waldir Gaioso, 4855 - Bairro Vista Linda / SP - CEP 045955620', '11988745688', 'tito@otorrino.com.br', '45687591128', 451257842),
			(8, 'Fabiano Gomide', '43544', 'SC', '1977-03-21', 'Avenida Franca, 326 - Bairro Vista Verde / SP - CEP 21453652', '11932445685', 'gomide@saude.com.br', '28264397748', 327458596),
			(9, 'Ezequiel Pestana Henriques', '48562', 'SP', '1982-01-25', 'Rua Rubião Junior, 875 - Bairro Centro / SP - CEP 12308245', '1132554685', 'pestana@endocrino.com.br', '32243242845', 423256781),
			(10, 'Alberto Veríssimo', '46522', 'SP', '1979-05-12', 'Rua Ali Alvez, 257 - Bairro Diamante / SP - CEP 02456875', '11955478699', 'verissimo@pediatra.com.br', '26235498817', 245632514),
			(11, 'Anny Quintanilha', '42845', 'SP', '1981-06-11', 'Rua Alberto Norteman, 5575 - Bairro Centro / SP - CEP 12453415', '11988419653', 'quintanilha@gmail.com', '56425931147', 458612432),
			(12, 'Mark Festas Santana', '41586', 'MG', '1980-12-25', 'Avenida Arthur Azevedo, 2453 - Bairro Pinheiros / SP - CEP 12340256', '1145996587', 'mfestas@trauma.com.br', '45263581142', 956235245),
			(13, 'Nelson Anjos Palmeira', '40524', 'RS', '1974-08-19', 'Avenida Francisco Paes, 854 - Bairro Centro / SP - CEP 23452782', '11988564582', 'anjosnelson@hmail.com', '85596417725', 458562175)
		;
	
INSERT INTO medico_especialidade (id_medico, id_especialidade)
	VALUES	(1, 1), (2, 1),	(3, 2), (4, 2), (4, 3), (5, 2),	(5, 4), (6, 3), (7, 3), (8, 3), (9, 4), (9, 5), (10, 4), (11, 3), (11, 4), (12, 6), (13, 7)	
		;
        
INSERT INTO tipo_quarto (id_tipo_quarto, descricao, valor_diaria)
	VALUES 	(1, 'Apartamento Prime - Apartamento alto padrão individual, com banheiro privativo, varanda e tv a cabo', 850.00),
			(2, 'Apartamento Simples - Apartamento padrão suíte individual', 550.00),
			(3, 'Quarto Duplo - Quarto padrão duplo com banheiro compartilhado', 350.00),
			(4, 'Enfermaria - Quarto padrão compartilhado com até 4 pacientes e banheiro compartilhado', 200.00)
		;
	
INSERT INTO quarto (id_quarto, numero, id_tipo_quarto)
	VALUES	(1, '501', 1),
			(2, '401', 2),
			(3, '301', 3),
			(4, '201', 4)
		;
        
INSERT INTO enfermeiro (id_enfermeiro, nome, cpf, cre)
	VALUES  (1, 'Pedro Afonso', '66079462087', '45856'),
			(2, 'Agatha Laís Martins', '64754248899', '55642'),
			(3, 'Isabela Lavínia Neves', '33253085899', '51653'),
			(4, 'Theo Breno Barbosa', '30264005805', '48562'),
			(5, 'Nathan Emanuel', '19557833815', '49565'),
			(6, 'Sabrina Jéssica','52957858827', '50653')
		;
        
 INSERT INTO internacao (id_internacao, data_entrada, data_prev_alta, data_alta, procedimento, medico_id_medico, paciente_id_paciente, quarto_id_quarto)
	VALUES 	(1, '2018-05-20', '2018-05-25', '2018-05-25', 'Retirada de mieloma de pele no braço, próximo ao cotovelo esquerdo', 1, 1, 3);
INSERT INTO internacao (data_entrada, data_prev_alta, data_alta, procedimento, medico_id_medico, paciente_id_paciente, quarto_id_quarto)
	VALUES 	( '2019-01-05', '2019-01-10', '2019-01-10', 'Retirada de novo mieloma no braço, próximo ao cotovelo esquerdo', 1, 1, 1),
			( '2019-06-21', '2019-06-23', '2019-06-23', 'Retirada da tireoide', 13, 10, 2),
			( '2020-04-12', '2020-04-30', '2020-04-30', 'Cirurgia de correção da valvula mitral do coração', 12, 18, 4),
			( '2020-05-20', '2020-06-25', '2020-06-25', 'Nova cirurgia de correção da valvula mitral do coração', 12, 18, 4),
			( '2021-02-16', '2021-03-15', '2021-03-15', 'Redução do estomago, colocação de balão', 3, 20, 4),
			( '2022-06-15', '2022-07-15', '2022-07-15', 'Quadro de Pneumonia', 9, 15, 2),
			( '2022-08-03', '2022-08-13', '2022-08-13', 'Quadro de Anemia', 2, 25, 1)
	;

INSERT INTO enfermeiro_internacao (id_enfermeiro, id_internacao)
	VALUES	(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 3), (4, 4), (5, 4), (6, 5), (1, 5), (2, 6), (3, 6), (4, 7), (5, 7)
	;
       
INSERT INTO consulta (id_consulta, data_consulta, hora, valor_consulta, carteirinha, id_medico, id_paciente, id_convenio, id_especialidade)
	VALUES 	(1, '2018-02-16', '09:10', 110.90, '55643215', 3, 3, 1, 2);
INSERT INTO consulta (id_consulta, data_consulta, hora, valor_consulta, carteirinha, id_medico, id_paciente, id_convenio, id_especialidade)
	VALUES 	(2, '2018-05-22', '08:20', 150.00, '21484234', 3, 3, 1, 2),
			(3, '2018-08-02', '08:45', 220.00, '12341234', 4, 6, 1, 2),
			(4, '2019-06-13', '08:30', 150.00, '12342342', 6, 7, 2, 3),
			(5, '2019-07-26', '09:10', 250.00, '11234214124', 7, 9, 2, 3),
			(6, '2020-08-13', '09:00', 110.90, '226672634', 9, 26, 8, 5),
			(7, '2020-09-14', '09:20', 120.00, null, 8, 21, null, 3),
			(8, '2020-10-04', '09:00', 220.00, '324324321', 11, 15, null, 3),
			(9, '2020-11-19', '09:45', 110.00, null, 2, 4, 2, 1),
			(10, '2021-02-08', '09:30', 120.00, null, 5, 16, null, 4)
		;

INSERT INTO receita (id_receita, data_receita, remedio1, posologia1, remedio2, posologia2, remedio3, posologia3, remedio4, posologia4, id_consulta, id_medico, id_paciente)
VALUES	(1, '2018-02-16', 'Paracetamol', 'Ingerir com água 1 comprimido, se sentir dor leve.','Trimedal 500mg', 'Tomar 1 comprimido por dia pela manha', null, null, null, null, 1, 3, 2);
INSERT INTO receita (data_receita, remedio1, posologia1, remedio2, posologia2, remedio3, posologia3, remedio4, posologia4, id_consulta, id_medico, id_paciente)
	VALUES  ('2018-05-22', 'Captropil 25 mg', '1 (um) comprimido por dia pela manha.', 'Cloridrato de metformina 500 mg', '1 (um) comprimido após o cafe por dia.', 'Budesonida 32 mcg/dose', 'Adminsitração tópica nasal doseada 1 (uma) dose pela manha', null, null, 2, 3, 3),
			('2018-08-02', 'Atenolol 25 mg', '1 (um) comprimido por dia pela manha.', 'Glifage XR 500 mg', '1 (um) comprimido após o cafe por dia.', null, null, null, null, 3, 4, 6),
			('2019-06-13', 'Alendronato de Sódio 70 mg', '1 (um) comprimido por dia pela manha.', null, null, null, null, null, null, 4, 6, 7),
			('2019-07-26', 'PuranT4 50 mg', '1 (um) comprimido por dia, 30 min. antes do café da manha.', 'Cloridrato de metformina 500 mg', '1 (um) comprimido após o almoço por dia.', 'Budesonida 32 mcg/dose', 'Adminsitração tópica nasal doseada 1 (uma) dose pela manha', null, null, 5 , 7, 9),
			('2020-08-13', 'Paracetamol', 'Ingerir com água 1 comprimido, se sentir dor leve.', 'XigDuoXR', '1 (um) comprimido após o cafe por dia.', 'Budesonida 32 mcg/dose', 'Adminsitração tópica nasal doseada 1 (uma) dose pela manha', null, null, 6, 9, 26),
			('2020-09-14', 'Cloridrato de metformina 500 mg', '1 (um) comprimido após o cafe por dia.', 'Budesonida 32 mcg/dose', 'Adminsitração tópica nasal doseada 1 (uma) dose pela manha', null, null, null, null, 7 , 8, 21),
			('2020-10-04', 'Trimedal 500mg', 'Tomar 1 comprimido por dia pela manha', null, null, null, null, null, null, 8, 11, 15),
			('2020-11-19', 'Atenolol 25 mg', '1 (um) comprimido por dia pela manha.', 'Glifage XR 500 mg', '1 (um) comprimido após o cafe por dia.', null, null, null, null, 9, 2, 4),
			('2021-02-08', 'Trimedal 500mg', 'Tomar 1 comprimido por dia pela manha', null, null, null, null, null, null,  10, 5, 16)
		;
 
 
   -- UPDATE necessário para poder realizar os exercícios proprostos na Atv 4.
   
UPDATE consulta SET carteirinha = null WHERE id_consulta = 3;
UPDATE consulta SET id_convenio = null WHERE id_consulta = 3;
UPDATE consulta SET carteirinha = null WHERE id_consulta = 8;
UPDATE consulta SET id_convenio = null WHERE id_consulta = 9;
UPDATE consulta SET carteirinha = '365598524' WHERE id_consulta = 10;
UPDATE consulta SET id_convenio = '7' WHERE id_consulta = 10;

UPDATE internacao set data_alta = adddate(data_prev_alta, INTERVAL 5 DAY) WHERE (id_internacao = 1); 
UPDATE internacao set data_alta = adddate(data_prev_alta, INTERVAL 5 DAY) WHERE (id_internacao = 2); 
UPDATE internacao set data_alta = adddate(data_prev_alta, INTERVAL 5 DAY) WHERE (id_internacao = 8); 



  -- Primeira pate, todos os dados e o valor médio das consultas do ano de 2020 realizadas sem convênio
 
SELECT * FROM consulta WHERE data_consulta > '2020-01-01' and data_consulta < '2020-12-31' and carteirinha is null;
SELECT AVG(valor_consulta) FROM consulta WHERE data_consulta > '2020-01-01' and data_consulta < '2020-12-31' and carteirinha is null;


  -- Segunda pate, todos os dados e o valor médio das consultas do ano de 2020 realizadas por convênio
 
SELECT * FROM consulta WHERE data_consulta > '2020-01-01' and data_consulta < '2020-12-31' and carteirinha is not null;
SELECT AVG(valor_consulta) FROM consulta WHERE data_consulta > '2020-01-01' and data_consulta < '2020-12-31' and carteirinha is not null;
  
  
  -- Terceira parte, todos os dados das internações que tiveram data de alta maior que a data prevista para a alta
  
SELECT * FROM internacao WHERE data_alta > data_prev_alta;
  
  
  -- Quarta parte, receituário completo da primeira consulta registrada com receituário associado
  
SELECT * FROM receita WHERE id_receita = 1;
  
  
  -- Quinta parte, todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio)
  
SELECT * FROM consulta WHERE valor_consulta = (SELECT max(valor_consulta) FROM consulta WHERE id_convenio is null );
SELECT * FROM consulta WHERE valor_consulta = (SELECT min(valor_consulta) FROM consulta WHERE id_convenio is null );
  
  
  -- Sexta parte, todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta
 
SELECT 
    i.id_internacao,
    i.data_entrada,
    i.data_prev_alta,
    i.data_alta,
    i.procedimento,
    m.nome AS nome_medico,
    p.nome AS nome_paciente,
    q.numero AS numero_quarto,
    tq.valor_diaria,
    DATEDIFF(i.data_alta, i.data_entrada) AS dias_internado,
    DATEDIFF(i.data_alta, i.data_entrada) * tq.valor_diaria AS total_custo_internacao
FROM
    internacao i
JOIN medico m ON i.medico_id_medico = m.id_medico
JOIN paciente p ON i.paciente_id_paciente = p.id_paciente
JOIN quarto q ON i.quarto_id_quarto = q.id_quarto
JOIN tipo_quarto tq ON q.id_tipo_quarto = tq.id_tipo_quarto;


-- Sétima parte, data, procedimento e número de quarto de internações em quartos do tipo “apartamento”

SELECT 
    i.data_entrada,
    i.procedimento,
    q.numero AS numero_quarto,
    tq.descricao AS tipo_quarto
FROM 
    internacao i
JOIN 
    quarto q ON i.quarto_id_quarto = q.id_quarto
JOIN 
    tipo_quarto tq ON q.id_tipo_quarto = tq.id_tipo_quarto
WHERE 
    tq.descricao IN ('Apartamento Prime - Apartamento alto padrão individual, com banheiro privativo, varanda e tv a cabo', 'Apartamento Simples - Apartamento padrão suíte individual');
    
    
-- Oitava parte, Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta

SELECT
    p.nome AS Nome_Paciente,
    c.data_consulta AS Data_Consulta,
    e.descricao_especialidade AS Especialidade
FROM
    consulta c
JOIN
    paciente p ON c.id_paciente = p.id_paciente
JOIN
    especialidade e ON c.id_especialidade = e.id_especialidade
WHERE
    TIMESTAMPDIFF(YEAR, p.data_nasc, c.data_consulta) < 18
    AND e.descricao_especialidade <> 'Pediatria'
ORDER BY
    c.data_consulta;


-- Nono exercício, Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.

SELECT 
    p.nome as 'Nome do Paciente',
    m.nome as 'Nome do Médico',
    i.data_entrada as 'Data da Internação',
    i.procedimento as 'Procedimento'
FROM
    paciente p
    JOIN internacao i ON p.id_paciente = i.paciente_id_paciente
    JOIN medico m ON m.id_medico = i.medico_id_medico
    JOIN medico_especialidade me ON m.id_medico = me.id_medico
    JOIN especialidade e ON e.id_especialidade = me.id_especialidade
    JOIN quarto q ON i.quarto_id_quarto = q.id_quarto
    JOIN tipo_quarto tq ON q.id_tipo_quarto = tq.id_tipo_quarto
WHERE
    e.descricao_especialidade = 'Gastroenterologia' 
    and tq.descricao = 'Enfermaria - Quarto padrão compartilhado com até 4 pacientes e banheiro compartilhado';
    
       
-- Décimo exercício, Os nomes dos médicos, seus números de registro no CRM e a quantidade de consultas que cada um realizou

SELECT
    m.nome AS Nome_Medico,
    m.crm AS CRM_Medico,
    COUNT(c.id_consulta) AS Qtd_Consultas
FROM
    medico m
JOIN
    consulta c ON m.id_medico = c.id_medico
GROUP BY
    m.id_medico, m.nome, m.crm;


-- Décimo primeiro exercicio, os nomes, os números de registro no CRE dos enfermeiros que participaram de mais de uma internação e os números de internações referentes a esses profissionais.

SELECT
    e.id_enfermeiro,
    e.nome AS nome_enfermeiro,
    e.cre,
    COUNT(distinct ei.id_internacao) AS num_internacoes
FROM
    enfermeiro e
JOIN enfermeiro_internacao ei ON e.id_enfermeiro = ei.id_enfermeiro
GROUP BY
    e.id_enfermeiro
HAVING
    COUNT(distinct ei.id_internacao) > 1;
    
    
-- Decimo segunda exercicio, Inclua ainda uma consulta extra idealizada por você. No script, em bloco de comentário, escreva o que a consulta deve trazer como resultado e, em seguida, escreva em SQL essa consulta. É necessário que essa consulta envolva múltiplas tabelas.

/*
Consulta Extra Idealizada:

Essa consulta deve trazer informações sobre as internações, pacientes e médicos associados a cada enfermeiro, 
juntamente com os dados do quarto em que o paciente está internado. O objetivo é obter uma visão geral 
das responsabilidades de cada enfermeiro nas internações, incluindo o nome do paciente, o médico responsável, 
a data de entrada e previsão de alta, e o número e tipo do quarto.

*/

SELECT 
    e.id_enfermeiro,
    e.nome AS enfermeiro_nome,
    i.id_internacao,
    i.data_entrada,
    i.data_prev_alta,
    i.procedimento,
    p.nome AS paciente_nome,
    m.nome AS medico_nome,
    q.numero AS numero_quarto,
    tq.descricao AS tipo_quarto
FROM 
    enfermeiro e
JOIN enfermeiro_internacao ei ON e.id_enfermeiro = ei.id_enfermeiro
JOIN internacao i ON ei.id_internacao = i.id_internacao
JOIN paciente p ON i.paciente_id_paciente = p.id_paciente
LEFT JOIN medico m ON i.medico_id_medico = m.id_medico
LEFT JOIN quarto q ON i.quarto_id_quarto = q.id_quarto
LEFT JOIN tipo_quarto tq ON q.id_tipo_quarto = tq.id_tipo_quarto;

