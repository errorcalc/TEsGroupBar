*** ErrorSoft(c) 2015-2016 ***

License: 
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
You can purchase a license for commercial use.

Support Delphi 2010 - Delphi Seattle (DX10)

ENG/RUS

====================================
[ENG]
====================================
*** You can help, if you send me where you are using the component and attach a screenshot example of use ***

TEsGroupBar - This sidebar is similar to the panel conductor XP, and allows the installation of any skin, In addition there is a support mode when one of the items selected.

The component is free for noncommercial use, you must specify in the About or elsewhere about using this component, preferably with reference to the repository. You can purchase a license for commercial use, $30 (for the Russians 2000RUR), writing to errorsoft@mail.ru or Enter256@yandex.ru.
After purchasing a license, you also get a year of free updates and technical support.

Can manufacturing of custom styles for you.

Installation:
----- Delphi2010-XE1 -----
1) Add "EsVclCore\Source" to search path (Tools->Options->Delphi Options->Library->Library path)
2) Compile EsVclCore (Build in the Project Manager)
3) Add "Source" to search path (Tools->Options->Delphi Options->Library->Library path)
4) Install EsGroupBar
5) Open a demo and make sure that the component is installed correctly

----- Delphi XE2-Higher -----
! Steps 1-4 should be performed only if you have not installed FreeEsVCLComponents.
! If there is no access to github.com/errorcalc/FreeEsVCLComponents, you must install as for Delphi2010-XE1
---
1) Download FreeEsVCLComponents with github.com/errorcalc/FreeEsVCLComponents
2) Add FreeEsVCLComponents/Source to search path (Tools-Options->Delphi Options->Library->Library path) 
3) Compile EsVclCore (Build in the Project Manager)
4) [Optional] If you wish to establish a set of free components of FreeEsVCLComponents
---
5) Add "Source" to search path (Tools->Options->Delphi Options->Library->Library path)
6) Install EsGroupBar
7) Open a demo and make sure that the component is installed correctly

Known issues:
1) PNG files are not loaded, the error Invalid Graphic Format:
Activate FixLoadPng in EsGroupBar.inc, and reinstall EsGroupBarPackage, if you have any problems downloading the images in PNG format in Design Time, because some packages installed (often AlphaSkins)

The component has support for loading / saving style (Load Style From File / Save Style To File)

====================================
[RUS]
====================================
*** Вы можете помочь, если вы пришлете мне, где вы используете компонент и приложите скриншот с примером использования ***

TEsGroupBar - Это боковая панель, подобная панели проводника в XP, позволяющая установку любого скина. Компонент имеет множество настроек, и может быть настроен на любой вкус.

Компонент бесплатен для некоммерческого использования, необходимо указать в About или в другом месте 
о использовании данного компонента, желательно с ссылкой на данный репозиторий.
Вы можете приобрести лицензию для коммерческого использования, стоимостью $30 (для Россиян 2000р), написав на errorsoft@mail.ru или Enter256@yandex.ru.
Приобретая лицензию, вы также получаете год бесплатных обновлений и техническую поддержку.

Возможно изготовление стилей на заказ.

Установка:
----- Delphi2010-XE1 -----
1) Прописать в Path путь на "EsVclCore\Source" (Tools->Options->Delphi Options->Library->Library path)
2) Скомпилировать EsVclCore (Build в Project Manager)
3) Прописать в Path путь на "Source" (Tools->Options->Delphi Options->Library->Library path)
4) Установить EsGroupBar
5) Открыть демку и убедиться, что компонент установлен корректно

----- Delphi XE2-Higher -----
! Шаги 1-4 необходимо выполнять только если вы не устанавливали FreeEsVCLComponents.
! Если нет доступа к github.com/errorcalc/FreeEsVCLComponents, то необходимо выполнить установку как для Delphi2010-XE1
---
1) Скачать FreeEsVCLComponents с github.com/errorcalc/FreeEsVCLComponents
2) Прописать в Path путь на FreeEsVCLComponents/Source (Tools->Options->Delphi Options->Library->Library path)
3) Скомпилировать EsVclCore (Build в Project Manager)
4) При желании установить набор бесплатных компонент FreeEsVCLComponents
---
5) Прописать в Path путь на "Source" (Tools->Options->Delphi Options->Library->Library path)
6) Установить EsGroupBar
7) Открыть демку и убедиться, что компонент установлен корректно

ИЗВЕСТНЫЕ ПРОБЛЕМЫ:
1) PNG файлы не загружаются, ошибка Invalid Graphic Format:
Активируйте FixLoadPng в EsGroupBar.inc, и переустановите EsGroupBarPackage, если у вас возникли проблемы с загрузкой изображений в формате PNG в Design Time, из-за некоторых установленных пакетов (чаще всего AlphaSkins)

Компонент имеет поддержку загрузки/сохранения стиля (Load Style From File/Save Style To File)
