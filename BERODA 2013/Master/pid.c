Pingki = ping1 + ping2+ ping3

Pingka = ping3+ ping4+ping5

PV = Pingka – Pingki (nilai kesalahan)

Max_MV = 100 (maximum nilai kesalahan)

Min_MV = -100 (minimum nilai kesalahan)

SP = 0 (nilai awal kesalahan)

Error = SP – PV (nilai kondisi ketika error)

Last_error = nilai untuk kondisi error yang terakhir terjadi.

Var_Kp = nilai untuk konstanta proporsional

Var_Ki = nilai untuk konstanta integral

Var_Kd = nilai untuk konstanta derivatif

MAXSpeed = 255 (nilai untuk kecepatan maximum)

MINSpeed = 0 (nilai untuk kecepatan minimum)

intervalPWM = (MAXSpeed – MINSpeed) / 5;

MAXPWM = MAXSpeed ;

MINPWM = MINSpeed;

Error = SP – PV;

P = (var_Kp * error) / 10;

I = I + error;

I = (I * var_Ki) / 10;

rate = error – last_error;

D = (rate * var_Kd) / 10;

last_error = error;

MV = P + I + D;

if (MV == 0) {

lpwm = MAXPWM;

rpwm = MAXPWM;

}

else if (MV > 0) { // alihkan ke kiri

rpwm = MAXPWM – ((intervalPWM – 20) * MV);

lpwm = (MAXPWM – (intervalPWM * MV) – 20);

if (lpwm < MINPWM) lpwm = MINPWM;

if (lpwm > MAXPWM) lpwm = MAXPWM;

if (rpwm < MINPWM) rpwm = MINPWM;

if (rpwm > MAXPWM) rpwm = MAXPWM;

}

else if (MV < 0) { // alihkan ke kanan

lpwm = MAXPWM + ( ( intervalPWM – 20 ) * MV);

rpwm = MAXPWM + ( ( intervalPWM * MV ) – 20 );

if (lpwm < MINPWM) lpwm = MINPWM;

if (lpwm > MAXPWM) lpwm = MAXPWM;

if (rpwm < MINPWM) rpwm = MINPWM;

if (rpwm > MAXPWM) rpwm = MAXPWM;

}

if (MV>Max _MV) { //belokan kanan siku

BlokKanan(); // belok kanan patah

lpwm = MAXPWM; //

rpwm = MINPWM; //

}

else if(MV<Min_MV) { //belokan kiri siku

BlokKiri(); // belok kiri patah

lpwm = MAXPWM; //

rpwm = MAXPWM; //