%let pgm=utl-remove-sn-initial-repeating-character-from-an-alphanumeric-field;

Remove initial repeating character from an alphanumeric field

Nice example of verify function

The SAS verify returns the position of the first value that is specified character

  Four solutions
       1. SAS datastep
       2. SAS sql
       3. WPS datastep
       4. WPS sql

stackOverflow
https://tinyurl.com/4wxb2zay
https://stackoverflow.com/questions/74597447/sas-proc-sql-remove-initial-zeros-from-an-alphanumeric-field

Peter Clemmensen
https://stackoverflow.com/users/4044936/peterclemmensen

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
input cod_acometida :$20.;
cards4;
000000000003391901
000000000008271401
000000000007696901
000000000005504701
000000000002298401
000000000000332701
000000000013942801
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Up to 40 obs from last table WORK.HAVE total obs=7 25APR2023:15:22:45                                                 */
/*                                                                                                                        */
/*  Obs      COD_ACOMETIDA                                                                                                */
/*                                                                                                                        */
/*   1     000000000003391901                                                                                             */
/*   2     000000000008271401                                                                                             */
/*   3     000000000007696901                                                                                             */
/*   4     000000000005504701                                                                                             */
/*   5     000000000002298401                                                                                             */
/*   6     000000000000332701                                                                                             */
/*   7     000000000013942801                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Up to 40 obs from WANT total obs=7 25APR2023:15:30:14                                                                 */
/*           COD_                                                                                                         */
/*  Obs    ACOMETIDA                                                                                                      */
/*                                                                                                                        */
/*   1     3391901                                                                                                        */
/*   2     8271401                                                                                                        */
/*   3     7696901                                                                                                        */
/*   4     5504701                                                                                                        */
/*   5     2298401                                                                                                        */
/*   6     332701                                                                                                         */
/*   7     13942801                                                                                                       */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                         _       _            _
/ |    ___  __ _ ___    __| | __ _| |_ __ _ ___| |_ ___ _ __
| |   / __|/ _` / __|  / _` |/ _` | __/ _` / __| __/ _ \ `_ \
| |_  \__ \ (_| \__ \ | (_| | (_| | || (_| \__ \ ||  __/ |_) |
|_(_) |___/\__,_|___/  \__,_|\__,_|\__\__,_|___/\__\___| .__/
                                                       |_|
*/

* verify returns the position of the first value that is not 0';

data want;
   set have;
   cod_acometida = substr(cod_acometida, verify(cod_acometida, '0'));
run;

/*___                                _
|___ \     ___  __ _ ___   ___  __ _| |
  __) |   / __|/ _` / __| / __|/ _` | |
 / __/ _  \__ \ (_| \__ \ \__ \ (_| | |
|_____(_) |___/\__,_|___/ |___/\__, |_|
                                  |_|
*/

proc sql;
  create
    table want_sas_sql as
  select
    substr(cod_acometida, verify(cod_acometida, '0')) as cod_acometida
  from
    have
;quit;

/*____                             _       _            _
|___ /   __      ___ __  ___    __| | __ _| |_ __ _ ___| |_ ___ _ __
  |_ \   \ \ /\ / / `_ \/ __|  / _` |/ _` | __/ _` / __| __/ _ \ `_ \
 ___) |   \ V  V /| |_) \__ \ | (_| | (_| | || (_| \__ \ ||  __/ |_) |
|____(_)   \_/\_/ | .__/|___/  \__,_|\__,_|\__\__,_|___/\__\___| .__/
                  |_|                                          |_|
*/

%let _pth=%sysfunc(pathname(work));
%utl_submit_wps64("
libname wrk '&_pth';
data want;
   set wrk.have;
   cod_acometida = substr(cod_acometida, verify(cod_acometida, '0'));
run;
proc print;
run;quit;
");

/*  _                                     _
| || |    __      ___ __  ___   ___  __ _| |
| || |_   \ \ /\ / / `_ \/ __| / __|/ _` | |
|__   _|   \ V  V /| |_) \__ \ \__ \ (_| | |
   |_|(_)   \_/\_/ | .__/|___/ |___/\__, |_|
                   |_|                 |_|
*/

%let _pth=%sysfunc(pathname(work));

%utl_submit_wps64("
options validvarname=any;
libname wrk '&_pth';
proc sql;
  create
    table want_sas_sql as
  select
    substr(cod_acometida, verify(cod_acometida, '0')) as cod_acometida
  from
    wrk.have
;quit;
proc print;
run;quit;
");

/**************************************************************************************************************************/
/*                                                                                                                        */
/* The WPS System                                                                                                         */
/*                                                                                                                        */
/* Obs    cod_acometida                                                                                                   */
/*                                                                                                                        */
/*  1       3391901                                                                                                       */
/*  2       8271401                                                                                                       */
/*  3       7696901                                                                                                       */
/*  4       5504701                                                                                                       */
/*  5       2298401                                                                                                       */
/*  6       332701                                                                                                        */
/*  7       13942801                                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
