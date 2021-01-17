CREATE TABLE peminjam (
    peminjam_id             NUMBER(9) PRIMARY KEY NOT NULL,
    nama_lengkap            VARCHAR2(100) NOT NULL,
    gender                  VARCHAR2(2) NOT NULL,
    id_pinjam               NUMBER(10) NOT NULL,
    status_sanksi_peminjam  NUMBER(1) NOT NULL
);

CREATE TABLE peminjaman (
    pinjam_id                  NUMBER(10) PRIMARY KEY NOT NULL,
    tanggal_peminjaman         DATE NOT NULL,
    tanggal_pengembalian       DATE NOT NULL
);

CREATE TABLE buku (
    buku_id               NUMBER(10) PRIMARY KEY NOT NULL,
    nama_buku             VARCHAR2(100 CHAR) NOT NULL,
    jumlah_halaman        NUMBER(5),
    tipe_buku             VARCHAR2(20),
    nama_penulis          VARCHAR2(50),
    stok_buku             NUMBER(5),
    id_penerbit           NUMBER(7)
);

CREATE TABLE penerbit (
    penerbit_id    NUMBER(7) PRIMARY KEY NOT NULL,
    nama_penerbit  VARCHAR2(30) NOT NULL,
    alamat         VARCHAR2(60)
);

CREATE TABLE status_anggota (
    status_sanksi   NUMBER(1) PRIMARY KEY NOT NULL,
    aktif_hingga    DATE NOT NULL
);

ALTER TABLE peminjam
ADD CONSTRAINT peminjam_peminjaman_fk FOREIGN KEY ( id_pinjam ) 
REFERENCES peminjaman ( pinjam_id );

ALTER TABLE peminjam
ADD CONSTRAINT peminjam_status_anggota_fk FOREIGN KEY ( status_sanksi_peminjam )
REFERENCES status_anggota ( status_sanksi );

ALTER TABLE buku
ADD CONSTRAINT buku_penerbit_fk FOREIGN KEY ( id_penerbit)
REFERENCES penerbit ( penerbit_id );

CREATE OR REPLACE TRIGGER status_anggota_status_anggota_ BEFORE
    INSERT ON status_anggota
    FOR EACH ROW
    WHEN ( new.status_anggota_id IS NULL )
BEGIN
    :new.status_anggota_id := status_anggota_status_anggota_.nextval;
END;

INSERT INTO BUKU VALUES (213322021, 'HTML Express', 205, 'Pemrograman,Teknologi','Ramadhan Bagus',45);

CREATE OR REPLACE FUNCTION hitung_denda(
    keterlambatan PLS_INTEGER
) 
RETURN NUMBER
IS
    total_denda NUMBER;
    denda_perhari NUMBER := 500;
BEGIN
    SELECT SUM(keterlambatan * denda_perhari)
    INTO total_denda
   
    RETURN total_denda;
END;

CREATE OR REPLACE FUNCTION sisa_denda(
    total_denda PLS_INTEGER
) 
RETURN NUMBER
IS
    sisa_denda NUMBER;
    denda_terbayar NUMBER;
BEGIN
    SELECT SUM(total_denda - denda_terbayar)

CREATE OR REPLACE PROCEDURE bayar_denda(
denda_terbayar NUMBER;
)
IS
    total_denda NUMBER;
    sisa_denda NUMBER;
BEGIN
    IF denda_terbayar >= total_denda THEN
        DBMS_OUTPUT.PUT.LINE (‘Denda Telah Terbayar Lunas’);
    ELSE
        DBMS_OUTPUT.PUT.LINE (‘Sisa denda yang harus dibayar ::=’||sisa_denda);
    ENDIF;
END;

CREATE OR REPLACE PROCEDURE cek_sanksi(
jenis_sanksi VARCHAR2;
)
IS
    jenis_pelanggaran VARCHAR2;
BEGIN
    IF jenis_pelanggaran := ‘Buku Rusak’ THEN
        jenis_sanksi := ‘Ganti Buku’;
    ELSIF tgl_pengembalian > tgl_pengembalian_maks THEN
        jenis_sanksi :=’Bayar Denda’;
    ENDIF;
END;


CREATE OR REPLACE TRIGGER stok_buku_pinjam
AFTER INSERT OR DELETE ON peminjaman
FOR EACH ROW
BEGIN
   IF INSERTING THEN    --Peminjaman, stok buku di perpus berkurang
	UPDATE buku SET stok = (stok - :new.jumlah) WHERE buku_id = :new.buku_id;
   ELSIF DELETING THEN    --Pengembalian, stok buku di perpus bertambah
	UPDATE produk SET stok = (stok + :old.jumlah) WHERE buku_id = :old.buku_id;
   END IF;
END;

CREATE OR REPLACE PACKAGE menentukan_sanksi AS
    PROCEDURE bayar_denda(total_denda);
    PROCEDURE mengganti_buku(nama_buku);
END cek_sanksi

CREATE OR REPLACE PACKAGE BODY menentukan_sanksi AS
    PROCEDURE cek_sanksi(new_sanksi_id NUMERIC)
    IS
        sanksi_new Sanksi%ROWTYPE;
    BEGIN
        SELECT *
        INTO sanksi_new
        FROM Sanksi
        WHERE sanksi_id = new_sanksi_id;
        dbms_output.put_line('Jenis pelanggaran');
        IF sanksi_new.jenis_pelanggaran := 'Buku Rusak' THEN
            dbms_output.put_line('Ganti Buku');
        ELSIF sanksi_new.tgl_pengembalian > sanksi_new.tnl_pengembalian_maks THEN
            dbms_output.put_line('Bayar Denda');
        ENDIF;
        
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line(SQLERRM);
    END;
