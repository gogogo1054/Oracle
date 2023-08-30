
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
	num  NOT NULL,
	title varchar2(200) NOT NULL,
	content varchar2(2000) NOT NULL,
	id varchar2(30) NOT NULL,
	postdate date NOT NULL,
	visitcount varchar2(0) NOT NULL,
	id varchar2(30) NOT NULL,
	PRIMARY KEY (num)
);


CREATE TABLE member
(
	id varchar2(30) NOT NULL,
	pass varchar2(30) NOT NULL,
	name varchar2(30) NOT NULL,
	-- 기본값(default)으로 sysdate 지정
	regidate date NOT NULL,
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE board
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;



/* Comments */

COMMENT ON COLUMN member.regidate IS '기본값(default)으로 sysdate 지정';



