      SUBROUTINE INTERP(TELE,TION,TN,XNION)
      INCLUDE 'SOLDIV.FI'
C   MICRO XSECT: LOG10-LOG10 INTERPOLATION ON SIGMA-V
	N = 1
	NLEG = 2
	NLEGEL =2 

C         INTERPOLATE ON NEUTRAL & ION TEMPERATURE RANGES
      IF(TION.GE.TINT(1).AND.TION.LT.TINT(2)) JN = 1
      IF(TION.GE.TINT(2).AND.TION.LE.TINT(3)) JN = 2
	IF(TION.GE.TINT(3).AND.TION.LE.TINT(4)) JN = 3
	IF(TION.GE.TINT(4).AND.TION.LE.TINT(5)) JN = 4
      IF(TN.GE.TINT(1).AND.TN.LT.TINT(2)) IN = 1
      IF(TN.GE.TINT(2).AND.TN.LE.TINT(3)) IN = 2
	IF(TN.GE.TINT(3).AND.TN.LT.TINT(4)) IN = 3
      IF(TN.GE.TINT(4).AND.TN.LE.TINT(5)) IN = 4
 
C         ELASTIC SCATTERING NEUTRAL-ION
      W1 = LOG10(ELAST(IN,JN)) + LOG10(ELAST(IN,JN+1)/ELAST(IN,JN))*
     2     LOG10(TION/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W2 = LOG10(ELAST(IN+1,JN)) + LOG10(ELAST(IN+1,JN+1)/
     2     ELAST(IN+1,JN))*
     3     LOG10(TION/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W = W1 +(W2-W1)*LOG10(TN/TINT(IN))/LOG10(TINT(IN+1)/TINT(IN))
      SEL(N) = 10.**W
C	**********reduce by 25%/CX double counting****************
	SEL(N) = 0.75*SEL(N)
C         ELASTIC SCATTERING NEUTRAL-NEUTRAL
      W = LOG10(ELASTN(IN)) + LOG10(ELASTN(IN+1)/ELASTN(IN))*
     2    LOG10(TN/TINT(IN))/LOG10(TINT(IN+1)/TINT(IN))
      SELN(N) = 10.**W
C	**********reduce by 25%/CX double counting****************
	SELN(N) = 0.75*SELN(N)
C         CHARGE-EXCHANGE ION-NEUTRAL
      W1 = LOG10(CX(IN,JN)) + LOG10(CX(IN,JN+1)/CX(IN,JN))*
     2     LOG10(TION/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W2 = LOG10(CX(IN+1,JN)) + LOG10(CX(IN+1,JN+1)/
     2     CX(IN+1,JN))*
     3     LOG10(TION/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W = W1 +(W2-W1)*LOG10(TN/TINT(IN))/LOG10(TINT(IN+1)/TINT(IN))
      SCX(N) = 10.**W
	GOTO 10
C         ELASTIC SCATTERING MOLECULE-ION & MOLECULE-ATOM
C          W = LOG10(ELASTM(JN)) + LOG10(ELASTM(JN+1)/ELASTM(JN))*
C     2     LOG10(TION(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      SVELM(N) = 10.**W
C         # ATOMS PRODUCED BY GROUND STATE ION/ATOM DISSOCIATION
C      W = LOG10(FRACN(JN)) + LOG10(FRACN(JN+1)/FRACN(JN))*
C     2     LOG10(TION(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      FRACTNI(N) = 10.**W

C         CHARGE-EXCHANGE ION-MOLECULE (FOLLOWED IMMEDIATELY BY DISSOCIATION)
C      W = LOG10(DISMI(JN)) + LOG10(DISMI(JN+1)/DISMI(JN))*
C     2     LOG10(TION(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      SVDISM(N) = 10.**W
C         INTERPOLATE ON ELECTRON DENSITY & TEMPERATURE RANGES
10    IF(XNION.GE.ZNINT(1).AND.XNION.LT.ZNINT(2)) IN = 1
      IF(XNION.GE.ZNINT(2).AND.XNION.LE.ZNINT(3)) IN = 2
	IF(XNION.GE.ZNINT(3).AND.XNION.LE.ZNINT(4)) IN = 3
	IF(XNION.GE.ZNINT(4).AND.XNION.LE.ZNINT(5)) IN = 4
 
      IF(TELE.GE.TINT(1).AND.TELE.LT.TINT(2)) JN = 1
      IF(TELE.GE.TINT(2).AND.TELE.LE.TINT(3)) JN = 2
	IF(TELE.GE.TINT(3).AND.TELE.LE.TINT(4)) JN = 3
	IF(TELE.GE.TINT(4).AND.TELE.LE.TINT(5)) JN = 4
C            ELECTRON-IMPACT IONIZATION
      W1 = LOG10(EION(IN,JN)) + LOG10(EION(IN,JN+1)/EION(IN,JN))*
     2     LOG10(TELE/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W2 = LOG10(EION(IN+1,JN)) + LOG10(EION(IN+1,JN+1)/
     2     EION(IN+1,JN))*
     3     LOG10(TELE/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W = W1 +(W2-W1)*LOG10(XNION/ZNINT(IN))/LOG10(ZNINT(IN+1)/
     2    ZNINT(IN))
      SION(N) = 10.**W
C         RECOMBINATION
      W1 = LOG10(REC(IN,JN)) + LOG10(REC(IN,JN+1)/REC(IN,JN))*
     2     LOG10(TELE/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W2 = LOG10(REC(IN+1,JN)) + LOG10(REC(IN+1,JN+1)/
     2     REC(IN+1,JN))*
     3     LOG10(TELE/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
      W = W1 +(W2-W1)*LOG10(XNION/ZNINT(IN))/LOG10(ZNINT(IN+1)/
     2    ZNINT(IN))
      RECOM(N) = 10.**W
	GOTO 100
C         # ATOMS PRODUCED BY GROUND STATE ELECTRON DISSOCIATION
C      W = LOG10(FRACEN(JN)) + LOG10(FRACEN(JN+1)/FRACEN(JN))*
C    2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      FRACTNE(N) = 10.**W
C		# D0 PRODUCED BY ELECTRON DISSOCIATION--EXCITED STATE
C	W = LOG10(FRACEXN(JN,1)) + LOG10(FRACEXN(JN+1,1)/FRACEXN(JN,1))*
C     2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      FRACTNEX(N,1) = 10.**W
C		# D+ PRODUCED BY ELECTRON DISSOCIATION--EXCITED STATE
C	W = LOG10(FRACEXN(JN,2)) + LOG10(FRACEXN(JN+1,2)/FRACEXN(JN,2))*
C     2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      FRACTNEX(N,2) = 10.**W
C		# D- PRODUCED BY ELECTRON DISSOCIATION--EXCITED STATE
C	W = LOG10(FRACEXN(JN,3)) + LOG10(FRACEXN(JN+1,3)/FRACEXN(JN,3))*
C     2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      FRACTNEX(N,3) = 10.**W

C			MOLECULAR EXCITATION
C	  W = LOG10(EXCITE(JN)) + LOG10(EXCITE(JN+1)/EXCITE(JN))*
C     2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      SVEXCIT(N) = 10.**W
C			ELECTRONIC DISSOCIATION OF GROUND STATE MOLECULES
C	  W = LOG10(DISME(JN)) + LOG10(DISME(JN+1)/DISME(JN))*
C     2     LOG10(TION(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      SVDESM(N) = 10.**W
C			ELECTRONIC DISSOCIATION OF EXCITED MOLECULES
C	W = LOG10(DISMEX(JN)) + LOG10(DISMEX(JN+1)/DISMEX(JN))*
C     2     LOG10(TELE(N)/TINT(JN))/LOG10(TINT(JN+1)/TINT(JN))
C      SVDISMEX(N) = 10.**W	  			

C         BEAM ANISOTROPIC SCATTERING FUNCTIONS
C         INTERPOLATE ON RATIO ION BEAM ENERGY TO NEUTRAL TEMPERATURE

C      RATIO = EBEAM(N)/TN(N)
C     IF(RATIO.LE.EN(1)) GOTO 40
C      IF(RATIO.GE.EN(5)) GOTO 42
C      IF(RATIO.GT.EN(1).AND.RATIO.LE.EN(2)) JN=1
C      IF(RATIO.GT.EN(2).AND.RATIO.LE.EN(3)) JN=2
C      IF(RATIO.GT.EN(3).AND.RATIO.LE.EN(4)) JN=3
C      IF(RATIO.GT.EN(4).AND.RATIO.LE.EN(5)) JN=4
C      DO 25 M=1,NLEG
C      DO 24 K=1,NLEGEL
C      W = SCATBM(M,K,JN) + (SCATBM(M,K,JN+1)-SCATBM(M,K,JN))*
C     2    LOG10(RATIO/EN(JN))/LOG10(EN(JN+1)/EN(JN))
C24    CONTINUE
C25    CONTINUE
C      GOTO 50
C40    DO 41 M=1,NLEG
C      DO 41 K=1,NLEGEL
C41    CONTINUE
C      GOTO 50
C42    DO 43 M=1,NLEG
C      DO 43 K=1,NLEGEL
C43    CONTINUE
C50    CONTINUE

100   RETURN
      END
