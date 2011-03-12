UPDATE passe_un SET moyenne_semestre=NULL;
ALTER TABLE passe_un MODIFY(moyenne_semestre NUMBER(4,2));
ALTER TABLE ue MODIFY(ECTS_UE NUMBER(4,2));
ALTER TABLE ecue MODIFY(ects_ecue NUMBER(4,2));
ALTER TABLE est_note_dans MODIFY(note_ecue NUMBER(4,2));
ALTER TABLE est_note_dans MODIFY(note_rattrapage_ecue NUMBER(4,2));


CREATE TABLE ETAPE (
CODE_ETAPE VARCHAR2(5),
LIBELLE_ETAPE VARCHAR2(20),
ECTS_ETAPE NUMBER(4,2),
CONSTRAINT pk_CODE_ETAPE PRIMARY KEY (CODE_ETAPE)
);

CREATE TABLE ETUDIANT (
CODE_ETUDIANT VARCHAR2(10),
NOM VARCHAR2(20),
PRENOM VARCHAR2(20),
SEXE VARCHAR2(1),
CONSTRAINT PK_CODE_ETUDIANT PRIMARY KEY (CODE_ETUDIANT)
);

drop table EST_DANS;
CREATE TABLE EST_DANS (
CODE_ETAPE VARCHAR2(5),
CODE_ETUDIANT VARCHAR2(20),
MOYENNE_ETAPE NUMBER(4,2),
DECISION_JURY_ETAPE VARCHAR2(20),
CONSTRAINT FK_CODE_ETAPE FOREIGN KEY (CODE_ETAPE) REFERENCES ETAPE(CODE_ETAPE),
CONSTRAINT FK_CODE_ETUDIANT FOREIGN KEY (CODE_ETUDIANT) REFERENCES ETUDIANT(CODE_ETUDIANT)
);

CREATE TABLE SEMESTRE (
CODE_SEMESTRE VARCHAR2(5),
CODE_ETAPE VARCHAR2(5),
LIBELLE_SEMESTRE VARCHAR2(20),
ECTS_SEMESTRE NUMBER(4,2),
CONSTRAINT PK_CODE_SEMESTRE PRIMARY KEY (CODE_SEMESTRE),
CONSTRAINT FK_CODE_ETAPE_SEM FOREIGN KEY (CODE_ETAPE) REFERENCES ETAPE (CODE_ETAPE)
);

CREATE TABLE PASSE_UN (
CODE_SEMESTRE VARCHAR2(5),
CODE_ETUDIANT VARCHAR2(20),
MOYENNE_SEMESTRE NUMBER(4,2),
POINT_JURY_SEMESTRE NUMBER(4,2),
DECISION_JURY_SEMESTRE VARCHAR2(20),
CONSTRAINT FK_CODE_SEMESTRE_PU FOREIGN KEY(CODE_SEMESTRE) REFERENCES SEMESTRE(CODE_SEMESTRE),
CONSTRAINT FK_CODE_ETUDIANT_PU FOREIGN KEY(CODE_ETUDIANT) REFERENCES ETUDIANT(CODE_ETUDIANT)
);

CREATE TABLE UE (
CODE_UE VARCHAR2(5),
CODE_SEMESTRE VARCHAR2(5),
LIBELLE_UE VARCHAR2(20),
ECTS_UE NUMBER(4,2),
OBLIGATOIRE VARCHAR2(3),
CONSTRAINT PK_CODE_UE PRIMARY KEY(CODE_UE),
CONSTRAINT FK_CODE_SEMESTRE_UE FOREIGN KEY (CODE_SEMESTRE) REFERENCES SEMESTRE (CODE_SEMESTRE)
);

drop table ecue;
CREATE TABLE ECUE (
CODE_ECUE VARCHAR2(5),
CODE_UE VARCHAR2(5),
LIBELLE_ECUE VARCHAR2(20),
ECTS_ECUE NUMBER(4,2),
CONSTRAINT PK_CODE_ECUE PRIMARY KEY(CODE_ECUE),
CONSTRAINT FK_CODE_UE_ECUE FOREIGN KEY (CODE_UE) REFERENCES UE (CODE_UE)
);

drop table est_inscrit_dans;
CREATE TABLE EST_INSCRIT_DANS (
CODE_ETUDIANT VARCHAR2(20),
CODE_UE VARCHAR2(5),
MOYENNE_UE NUMBER(4,2),
POINT_JURY_UE NUMBER(4,2),
DECISION_JURY_UE VARCHAR2(20),
CONSTRAINT FK_CODE_ETUDIANT_EIA FOREIGN KEY (CODE_ETUDIANT) REFERENCES ETUDIANT(CODE_ETUDIANT),
CONSTRAINT FK_CODE_UE_EIA FOREIGN KEY (CODE_UE) REFERENCES UE(CODE_UE)
);

drop table est_note_Dans;

CREATE TABLE EST_NOTE_DANS (
CODE_ETUDIANT VARCHAR2(20),
CODE_ECUE VARCHAR2(5),
NOTE_ECUE NUMBER(4,2), 
NOTE_RATTRAPAGE_ECUE NUMBER(4,2),
CONSTRAINT FK_CODE_ETUDIANT_END FOREIGN KEY (CODE_ETUDIANT) REFERENCES ETUDIANT(CODE_ETUDIANT),
CONSTRAINT FK_CODE_ECUE_END FOREIGN KEY (CODE_ECUE) REFERENCES ECUE(CODE_ECUE)
);

insert into etape values ('12345', 'doubi', 0);
insert into etape values ('6789', 'doubi', 0);
	
	
insert into etudiant values ('0110', 'Dejean', 'Quentin', 'm');
insert into etudiant values ('1110', 'Vacher', 'Damien', 'm');
insert into etudiant values ('1100', 'Pastou', 'Raphaël', 'm');
insert into etudiant values ('1111', 'Damiano', 'Emmanuel', 'm');
	
insert into est_Dans values ('12345', '0110', 12.00, 'admis');
insert into est_Dans values ('12345', '1110', 8.02, 'redoublant');
insert into est_Dans values ('12345', '1100', 14.00, 'admis');
insert into est_Dans values ('12345', '1111', 15.00, 'admis');
	
insert into semestre values('S01', '12345', 'Semestre 1', 15);
insert into semestre values('S02', '12345', 'Semestre 2', 30);
	
insert into Passe_un values ('S01', '0110', 12.00, '', 'valide');
insert into Passe_un values ('S01', '1110', 12.00, '', 'valide');
insert into Passe_un values ('S01', '1100', 12.00, '', 'valide');
insert into Passe_un values ('S01', '1111', 12.00, '', 'valide');
insert into Passe_un values ('S02', '0110', 12.00, '', 'valide');
insert into Passe_un values ('S02', '1110', 12.00, '', 'valide');
insert into Passe_un values ('S02', '1100', 12.00, '', 'valide');
insert into Passe_un values ('S02', '1111', 12.00, '', 'valide');
	
insert into UE values('UE01', 'S01', 'UE 1', 3, 'oui');
insert into UE values('UE02', 'S02', 'UE 2', 4, 'oui');
	
insert into est_inscrit_dans values ('0110', 'UE01', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1110', 'UE01', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1100', 'UE01', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1111', 'UE01', 12.00, '', 'valide');
insert into est_inscrit_dans values ('0110', 'UE02', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1110', 'UE02', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1100', 'UE02', 12.00, '', 'valide');
insert into est_inscrit_dans values ('1111', 'UE02', 12.00, '', 'valide');
	
insert into ECUE values('ECUE1', 'UE01', 'ECUE 1', 3);
insert into ECUE values('ECUE2', 'UE01', 'ECUE 2', 3);
insert into ECUE values('ECUE3', 'UE02', 'ECUE 3', 3);
insert into ECUE values('ECUE4', 'UE02', 'ECUE 4', 3);
	
insert into est_note_dans values ('0110', 'ECUE1', 12.00, '');
insert into est_note_dans values ('0110', 'ECUE2', 12.00, '');
insert into est_note_dans values ('0110', 'ECUE3', 12.00, '');
insert into est_note_dans values ('0110', 'ECUE4', 12.00, '');
	
insert into est_note_dans values ('1110', 'ECUE1', 12.00, '');
insert into est_note_dans values ('1110', 'ECUE2', 12.00, '');
insert into est_note_dans values ('1110', 'ECUE3', 12.00, '');
insert into est_note_dans values ('1110', 'ECUE4', 12.00, '');
	
insert into est_note_dans values ('1100', 'ECUE1', 12.00, '');
insert into est_note_dans values ('1100', 'ECUE2', 12.00, '');
insert into est_note_dans values ('1100', 'ECUE3', 12.00, '');
insert into est_note_dans values ('1100', 'ECUE4', 12.00, '');
	
insert into est_note_dans values ('1111', 'ECUE1', 12.00, '');
insert into est_note_dans values ('1111', 'ECUE2', 12.00, '');
insert into est_note_dans values ('1111', 'ECUE3', 12.00, '');
insert into est_note_dans values ('1111', 'ECUE4', 12.00, '');	
	
	select e.code_etudiant, e.nom, e.prenom, ed.moyenne_etape 
	from etudiant e, est_dans ed
	where ed.code_etape = '12345' and ed.code_etudiant = e.code_etudiant;
	
	
	select e.code_etudiant, e.nom, e.prenom, ed.moyenne_semestre 
	from etudiant e, passe_un ed 
	where ed.code_semestre = 'S02' and ed.code_etudiant = e.code_etudiant;
	
	select e.code_etudiant, e.nom, e.prenom, ed.moyenne_etape 
			from etudiant e, est_dans ed
			where ed.code_etape = '12345' and ed.code_etudiant = e.code_etudiant;
			
			select s.code_semestre, s.libelle_semestre, s.ects_semestre
							from semestre s
							where s.code_etape = '12345';
	
