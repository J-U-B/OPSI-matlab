# ![](./SRC/CLIENT_DATA/images/matlab_install.png "Matlab") MATLAB #

## ToC ##

* [Paketinfo](#paketinfo)
* [Paket erstellen](#paket_erstellen)
  * [Makefile und spec.json](#makefile_und_spec)
  * [pystache](#pystache)
  * [Verzeichnisstruktur](#verzeichnisstruktur)
  * [Makefile-Parameter](#makefile_parameter)
  * [spec.json](#spec_json)
* [Installation](#installation)
* [Allgemeines](#allgemeines)
  * [Properties](#properties)
  * [Aufbau des Paketes](#paketaufbau)
  * [Nomenklatur](#nomenklatur)
* [Lizenzen](#lizenzen)
  * [Dieses Paket](#licPaket)
  * [psDetail](#licPsDetail)
  * [GetRealName](#licGetRealName)
  * [7zip](#lic7zip)
  * [Logo](#logo)
* [Anmerkungen/ToDo](#anmerkungen_todo)



<div id="paketinfo"></div>

## Paketinfo ##

Dieses OPSI-Paket (bzw. dessen Quellen) fuer **MATLAB** wurde fuer die Installation
der Version **R2017b** der Software erstellt. Prinzipiell (ggf. mit geringfuegigen
Anpassungen) ist jedoch eine Verwendung mit anderen Releases moeglich. Hierfuer
wird jedoch keine verbindliche Zusage getroffen. -- Feedback ist jedoch jederzeit
willkommen

Das Paket wurde aus dem internen Paket des *Max-Planck-Institut fuer Mikrostrukturphysik*
abgeleitet und fuer die Verwendung im *DFN*-Repository angepasst und erweitert.
Es wird versucht auf die Besonderheiten der jeweiligen Repositories einzugehen;
entsprechend werden durch ein einfaches ***Makefile*** aus den Quellen verschiedene
Pakete erstellt.

Teile dieser Dokumentation beziehen sich nicht ausschliesslich auf die erstellten 
OSPI-Pakete, sondern beruecksichtigen auch den Build-Prozess.



<div id="paket_erstellen"></div>

## Paket erstellen ##

Dieser Abschnitt beschaeftigt sich mit der Erstellung des OPSI-Paketes aus
dem Source-Paket und nicht mit dem OPSI-Paket selbst.



<div id="makefile_und_spec"></div>

### Makefile und spec.json ###

Da aus den Quellen verschiedene Versionen des Paketes mit entsprechenden Anpassungen
generiert werden sollen (intern, DFN; testing/release) wurde hierfuer ein
**<code>Makefile</code>** erstellt. Darueber hinaus steuert **<code>spec.json</code>** 
die Erstellung der Pakete.



<div id="pystache"></div>

### pystache ###

Als Template-Engine kommt **<code>pystache</code>** zum Einsatz.
Das entsprechende Paket ist auf dem Build-System aus dem Repository der verwendeten
Distribution zu installieren.

Unter Debian/Ubuntu erledigt das:
> <code>sudo apt-get install python-pystache</code>



<div id="verzeichnisstruktur"></div>

### Verzeichnisstruktur ###

Die erstellten Pakete werden im Unterverzeichnis **<code>PACKAGES</code>** abgelegt.

Einige Files (control, postinst, setup.opsiscript) werden bei der Erstellung erst aus _<code>.in</code>_-Files
generiert, welche sich in den Verzeichnissen <code>SRC/OPSI</code> und <code>SRC/CLIENT_DATA</code> befinden.
Die <code>SRC</code>-Verzeichnisse sind in den OPSI-Paketen nicht mehr enthalten.

Fuer den eigentlichen Buildvorgang wird das Verzeichnis **<code>BUILD</code>**
verwendet.



<div id="makefile_parameter"></div>

### Makefile-Parameter ###
OPSI erlaubt des Pakete im Format <code>cpio</code> und <code>tar</code> zu erstellen.  
Als Standard ist <code>cpio</code> festgelegt.  
Das Makefile erlaubt die Wahl des Formates ueber die Umgebungsvariable bzw. den Parameter:
> *<code>ARCHIVE_FORMAT=&lt;cpio|tar&gt;</code>*

Eine kurze Hilfe zu den verfuegbaren *Targets* und Optionen liefert
> *<code>make help</code>*



<div id="spec_json"></div>

### spec.json ###

Haeufig beschraenkt sich die Aktualisierung eines Paketes auf das Aendern der 
Versionsnummern und des Datums etc. In einigen Faellen ist jedoch auch das Anpassen
weiterer Variablen erforderlich, die sich auf verschiedene Files verteilen.  
Auch das soll durch das Makefile vereinfacht werden. Die relevanten Variablen
sollen nur noch in <code>spec.json</code> angepasst werden. Den Rest uebernimmt *<code>make</code>*



<div id="installation"></div>

## Installation ##

Die Software selbst wird <u>nicht</u> mit diesem Paket vertrieben!

Fuer die Benutzung des Paketes sind die Installationsfiles unterhalb des Verzeichnisses
<code>**files**</code> zu kopieren. Alternativ kann das Quellverzeichnis ueber die
Properties des Paketes angegeben werden. Dieses Verzeichnis muss selbstredend fuer
den OPSI-Installer lesbar sein.

Benutzerdefinierte Skripte, Konfigurationen (product_list_file) sowie Installations-Schluessel
und Lizenzfiles koennen unter <code>**custom**</code> abgelegt werden.



<div id="allgemeines"></div>

## Allgemeines ##


<div id="properties"></div>

### Properties ###

| Property | Type | Values | Default  | Multivalue | Editable | Description | Note |
|----------|:----:|--------|----------|:----------:|:--------:|-------------|------|
| install_source | unicode | "", (edit) | "" | False | True | Source for installation files; relative to this package | | 
| install_key | unicode | (edit) | "" | False | True | Installation Key or relative path to a file containing the key | required! |
| license_file | unicode | (edit) | "" | False | True | License file; relative to this package | |
| setup_mode | unicode | "silent", "automated", "interactive" | "silent" | False | False| Installer mode | *automated* also interacts with desktop; user input may be required|
| product_list_file | unicode | (edit) | "" | False | True | Products to install or remove; relative path to a file containing list | |
| product_list | unicode | (List of products) | "" | True | False | Products to install or remove; supplements product_list_file | |
| file_association | bool | | True | | | Set file associations to MATLAB | |
| create_accel_task | bool | | False | | | Create a MATLAB Startup Accelerator task | |
| enable_named_user | bool | | False | | | Enable Login Named User licensing; users must log in to their MathWorks Account when MATLAB starts | |
| automated_mode_timeout | unicode | 0, 1, 1000, 5000, 10000| 1 | False| False | Specify how long the installer dialog boxes are displayed (milliseconds); only used for automated mode | |
| answer_installer | unicode | "cfg/opsi_installer_input.txt", (edit) | "" | False | True | input file for silent installation | |
| answer_uninstaller | unicode | "cfg/opsi_uninstaller_input.txt", (edit) | "" | False | True | input file for silent uninstall | |
| kill_running | bool |  | False |  |  | kill running instance (for software on_demand) | verfuegbar wenn in spec.json aktiviert |
| uninstall_before_setup | bool |  | False |  |  | Run uninstall before (re)installation; installer will remove previous setup anyway | |
| remove_prefs | bool |  | True |  |  | remove MATLAB preferences when uninstalling | |
| purge_directory | bool |  | False |  |  | forced purge of installation directory on uninstall | |
| link_desktop | bool |  | False |  |  | Generate or delete Desktop link | |
| link_startmenu | bool |  | True |  |  | Generate or delete Start menu entry | |
| custom_post_install | unicode | "none", "custom_test.opsiinc", "post-install.opsiinc" | "none" | False | True | Define filename for include script in custom directory after installation |  |
| custom_post_uninstall | unicode | "none", "custom_test.opsiinc", "post-uninstall.opsiinc" | "none" | False | True | Define filename for include script in custom directory after deinstallation |  |
| log_level | unicode | "default", "1", "2", "3", "4", "5", "6", "7", "8", "9" | "default" | False | False | Loglevel for this package |  |

Je nach Art des erstellten Paketes und den Einstellungen in der <code>spec.json</code>
koennen die verfuegbaren Properties abweichen.

In der Regel sollte die Installation im "*silent*"-Mode erfolgen. Dabei ist allerdings
kein Fortschritt ablesbar. Im Hinblick auf den Umfang des Softwarepakets kann
das fuer den potentiellen Betrachter irritierend sein. Es werden daher auch die
Modi "*automated*" und "*interactive*" angeboten. Beide erlauben oder erfordern
jedoch lokale Interaktion.  
Im "*automated*"-Mode beschraenkt sich die bisher einzig beobachtete <u>erforderliche</u>
Interaktion im Uninstaller auf einen Bestaetigungsdialog bezueglich der Deaktivierung 
der Lizenz.

Weitere Details zum automatisierten Setup und zu den Parametern in den von
den Skripten erstellten Answer-Files finden sich in der ```install_guide.pdf```
in der MATALB-Distribution, sowie in der ```installer_input.txt```.  
Eine ```uninstaller_input.txt``` findet sich spaeter im Verzeichnis ```uninstall```
der Installation.



<div id="paketaufbau"></div>

### Aufbau des Paketes ###

* **<code>variables.opsiinc</code>** - Da Variablen ueber die Scripte hinweg mehrfach
verwendet werden, werden diese (bis auf wenige Ausnahmen) zusammengefasst hier deklariert.
* **<code>product_variables.opsiinc</code>** - die producktspezifischen Variablen werden
hier definiert
* **<code>setup.opsiscript </code>** - Das Script fuer die Installation.
* **<code>uninstall.opsiscript</code>** - Das Uninstall-Script
* **<code>delsub.opsiinc</code>**- Wird von Setup und Uninstall gemeinsam verwendet.
Vor jeder Installation/jedem Update wird eine alte Version entfernt. (Ein explizites
Update-Script existiert derzeit nicht.)
* **<code>checkinstance.opsiinc</code>** - Pruefung, ob eine Instanz der Software laeuft.
Gegebenenfalls wird das Setup abgebrochen. Optional kann eine laufende Instanz 
zwangsweise beendet werden.
* **<code>checkvars.sh</code>** - Hilfsscript fuer die Entwicklung zur Ueberpruefung,
ob alle verwendeten Variablen deklariert sind bzw. nicht verwendete Variablen
aufzuspueren.
* **<code>bin/</code>** - Hilfprogramme; hier: **7zip**, **psdetail**
* **<code>images/</code>** - Programmbilder fuer OPSI



<div id="nomenklatur"></div>

### Nomenklatur ###

Praefixes in der Produkt-Id definieren die Art des Paketes:

* **0_** oder **test_** - Es handelt sich um ein Test-Paket. Beim Uebergang zur Produktions-Release
wird der Praefix entfernt.
* **dfn_** - Das Paket ist zur Verwendung im DFN-Repository vorgesehen.

Die Reihenfolge der Praefixes ist relevant; die Markierung als Testpaket ist 
stets fuehrend.



<div id="lizenzen"></div>

## Lizenzen ##


<div id="licPaket"></div>

###  Dieses Paket ###

Dieses OPSI-Paket steht unter der *GNU General Public License* **GPLv3**.

Ausgenommen von dieser Lizenz sind die unter **<code>bin/</code>** zu findenden
Hilfsprogramme. Diese unterliegen ihren jeweiligen Lizenzen.



<div id="licPsDetail"></div>

### psDetail ###
**Autor** der Software: Jens Boettge <<boettge@mpi-halle.mpg.de>> 

Die Software **psdetail.exe**  wird als Freeware kostenlos angeboten und darf fuer 
nichtkommerzielle sowie kommerzielle Zwecke genutzt werden. Die Software
darf nicht veraendert werden; es duerfen keine abgeleiteten Versionen daraus 
erstellt werden.

Es ist erlaubt Kopien der Software herzustellen und weiterzugeben, solange 
Vervielfaeltigung und Weitergabe nicht auf Gewinnerwirtschaftung oder Spendensammlung
abzielt.

Haftungsausschluss:  
Der Auto lehnt ausdruecklich jede Haftung fuer eventuell durch die Nutzung 
der Software entstandene Schaeden ab.  
Es werden keine ex- oder impliziten Zusagen gemacht oder Garantien bezueglich
der Eigenschaften, des Funktionsumfanges oder Fehlerfreiheit gegeben.  
Alle Risiken des Softwareeinsatzes liegen beim Nutzer.

Der Autor behaelt sich eine Anpassung bzw. weitere Ausformulierung der Lizenzbedingungen
vor.

Fuer die Nutzung wird das *.NET Framework ab v3.5*  benoetigt.



<div id="licGetRealName"></div>

### GetRealName ###
**Autor** der Software: Jens Boettge <<boettge@mpi-halle.mpg.de>> 

Die Software **GetRealName.exe**  wird als Freeware kostenlos angeboten und darf fuer 
nichtkommerzielle sowie kommerzielle Zwecke genutzt werden. Die Software
darf nicht veraendert werden; es duerfen keine abgeleiteten Versionen daraus 
erstellt werden.

Es ist erlaubt Kopien der Software herzustellen und weiterzugeben, solange 
Vervielfaeltigung und Weitergabe nicht auf Gewinnerwirtschaftung oder Spendensammlung
abzielt.

Haftungsausschluss:  
Der Auto lehnt ausdruecklich jede Haftung fuer eventuell durch die Nutzung 
der Software entstandene Schaeden ab.  
Es werden keine ex- oder impliziten Zusagen gemacht oder Garantien bezueglich
der Eigenschaften, des Funktionsumfanges oder Fehlerfreiheit gegeben.  
Alle Risiken des Softwareeinsatzes liegen beim Nutzer.

Der Autor behaelt sich eine Anpassung bzw. weitere Ausformulierung der Lizenzbedingungen
vor.



<div id="lic7zip"></div>

### 7zip ###
Es gilt die Lizenz von http://www.7-zip.org/license.txt.



<div id="logo"></div>

### Logo ###
Grundlage fuer das erstellte Logo war https://en.wikipedia.org/wiki/MATLAB#/media/File:Matlab_Logo.png.  
Die Variationen des Icon-Satzes fuer das OPSI-Paket wurden von mir unter Verwendung
weiterer freier Grafiken erstellt.



<div id="anmerkungen_todo"></div>

## Anmerkungen/ToDo ##


-----
Jens Boettge <<boettge@mpi-halle.mpg.de>>, 2017-11-24 07:19:05 +0100
