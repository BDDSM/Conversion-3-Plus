﻿
#Область ОписаниеПеременных

&НаКлиенте
Перем КонсольКодаПриОбработке;

&НаКлиенте
Перем КонсольКодаВыборкаДанных;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура Расш1_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	Элементы.АлгоритмПриОбработке.Видимость = Ложь;
	Элементы.АлгоритмВыборкаДанных.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПриОткрытииПосле(Отказ)
	
	ПриОбработкеHTML = АдресКонсолиКода;
	ВыборкаДанныхHTML = АдресКонсолиКода;
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ПередЗаписьюПосле(Отказ, ПараметрыЗаписи)
	
	// Запишем новый текст в реквизиты.
	Объект.АлгоритмПриОбработке = КонсольКодаПриОбработке.getText();
	Объект.АлгоритмВыборкаДанных = КонсольКодаВыборкаДанных.getText();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Расш1_ПриОбработкеHTMLДокументСформированПосле(Элемент)
	
	КонсольКодаПриОбработке = Элементы.ПриОбработкеHTML.Документ.defaultView;
	Расш1_КонсольКода.ИнициализацияРедактора(КонсольКодаПриОбработке, Объект.АлгоритмПриОбработке);
	
КонецПроцедуры

&НаКлиенте
Процедура Расш1_ВыборкаДанныхHTMLДокументСформированПосле(Элемент)
	
	КонсольКодаВыборкаДанных = Элементы.ВыборкаДанныхHTML.Документ.defaultView;
	Расш1_КонсольКода.ИнициализацияРедактора(КонсольКодаВыборкаДанных, Объект.АлгоритмВыборкаДанных);
	
КонецПроцедуры

#КонецОбласти
