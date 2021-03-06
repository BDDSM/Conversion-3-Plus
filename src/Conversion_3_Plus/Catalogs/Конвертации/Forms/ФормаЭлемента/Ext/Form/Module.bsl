﻿#Область ОписаниеПеременных

&НаКлиенте
Перем КонсольКодаПередКонвертацией;

&НаКлиенте
Перем КонсольКодаПередОтложеннымЗаполнением;

&НаКлиенте
Перем КонсольКодаПослеКонвертации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура Расш1_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	Элементы.АлгоритмПередКонвертацией.Видимость = Ложь;
	Элементы.АлгоритмПередОтложеннымЗаполнением.Видимость = Ложь;
	Элементы.АлгоритмПослеКонвертации.Видимость = Ложь;
	
	//VanessaEditorLoad();
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПриОткрытииПосле(Отказ)
	
	ПередКонвертациейHTML = АдресКонсолиКода;
	ПередОтложеннымЗаполнениемHTML = АдресКонсолиКода;
	ПослеКонвертацииHTML = АдресКонсолиКода;
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПередЗаписьюПосле(Отказ, ПараметрыЗаписи)
	
	// Запишем новый текст в реквизиты.
	Объект.АлгоритмПередКонвертацией = КонсольКодаПередКонвертацией.getText();
	Объект.АлгоритмПередОтложеннымЗаполнением = КонсольКодаПередОтложеннымЗаполнением.getText();
	Объект.АлгоритмПослеКонвертации = КонсольКодаПослеКонвертации.getText();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Расш1_ПередКонвертациейHTMLДокументСформированПосле(Элемент)
	
	КонсольКодаПередКонвертацией = Элементы.ПередКонвертациейHTML.Документ.defaultView;
	//КонсольКодаПередКонвертацией.createVanessaEditor("", "bsl");
	
	Расш1_КонсольКода.ИнициализацияРедактора(КонсольКодаПередКонвертацией, Объект.АлгоритмПередКонвертацией);
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПередОтложеннымЗаполнениемHTMLДокументСформированПосле(Элемент)
	
	КонсольКодаПередОтложеннымЗаполнением = Элементы.ПередОтложеннымЗаполнениемHTML.Документ.defaultView;
	Расш1_КонсольКода.ИнициализацияРедактора(КонсольКодаПередОтложеннымЗаполнением, Объект.АлгоритмПередОтложеннымЗаполнением);
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПослеКонвертацииHTMLДокументСформированПосле(Элемент)
	
	КонсольКодаПослеКонвертации = Элементы.ПослеКонвертацииHTML.Документ.defaultView;
	Расш1_КонсольКода.ИнициализацияРедактора(КонсольКодаПослеКонвертации, Объект.АлгоритмПослеКонвертации);
	
КонецПроцедуры

#КонецОбласти

//&НаСервере
//Procedure VanessaEditorLoad()
//	
//	Макет = ПолучитьОбщийМакет("VanessaEditor");
//	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
//	УдалитьФайлы(ИмяВременногоФайла);
//	СоздатьКаталог(ИмяВременногоФайла);
//	
//	ЧтениеZipФайла = Новый ЧтениеZipФайла(Макет.OpenStreamForRead());
//	Для Каждого ФайлАрхива In ЧтениеZipФайла.Элементы Цикл
//		ЧтениеZipФайла.Извлечь(ФайлАрхива, ИмяВременногоФайла, РежимВосстановленияПутейФайловZIP.Восстанавливать);
//		ДвоичныеДанные = Новый ДвоичныеДанные(ИмяВременногоФайла + ПолучитьРазделительПути() + ФайлАрхива.ПолноеИмя);
//		ПередКонвертациейHTML = GetInfoBaseURL() + "/" + ПоместитьВоВременноеХранилище(ДвоичныеДанные, УникальныйИдентификатор)
//			+ "&localeCode=" + Лев(ТекущийЯзыкСистемы(), 2);
//	КонецЦикла;
//	УдалитьФайлы(ИмяВременногоФайла);

//EndProcedure