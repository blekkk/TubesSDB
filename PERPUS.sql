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

CREATE TABLE ganti_buku (
    nama_buku         VARCHAR2(100) NOT NULL
);

CREATE TABLE penerbit (
    penerbit_id    NUMBER(7) PRIMARY KEY NOT NULL,
    nama_penerbit  VARCHAR2(30) NOT NULL,
    alamat         VARCHAR2(60)
);

CREATE TABLE sanksi (
    sanksi_id           NUMBER(7) PRIMARY KEY NOT NULL,
    jenis_pelanggaran   VARCHAR2(30) NOT NULL
);

CREATE TABLE denda (
    denda_id        NUMBER(5) PRIMARY KEY NOT NULL,
    denda_perhari   INTEGER NOT NULL,
    total_denda     INTEGER NOT NULL
);

CREATE TABLE status_anggota (
    aktif_hingga    DATE NOT NULL,
    status_sanksi   NUMBER(1) NOT NULL
);

ALTER TABLE peminjam
ADD CONSTRAINT peminjam_pinjaman_fk FOREIGN KEY ( id_pinjam ) 
REFERENCES pinjaman ( pinjam_id );

ALTER TABLE peminjam
ADD CONSTRAINT peminjam_status_anggota_fk FOREIGN KEY ( status_sanksi_peminjam )
REFERENCES status_anggota ( status_sanksi );

ALTER TABLE buku
ADD CONSTRAINT buku_penerbit_fk FOREIGN KEY ( id_penerbit)
REFERENCES penerbit ( penerbit_id );
