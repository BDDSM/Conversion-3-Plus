﻿// Этот модуль пока не используется, т.к. описывать метаданные этой конфигурации нет смысла.
// Нужно будет составлять описание источника и приемника при запуске КД, хранить где то в параметрах сеанса.
// А в нужных модулях запускать.

Функция ЗаполнитьКоллекциюМетаданных(АдресРезультата = Неопределено) Экспорт
	
	КоллекцияМетаданных = Новый Структура();
	КоллекцияМетаданных.Вставить("catalogs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Справочники));
	КоллекцияМетаданных.Вставить("documents", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Документы));
	КоллекцияМетаданных.Вставить("infoRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыСведений));
	КоллекцияМетаданных.Вставить("accumRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыНакопления));
	КоллекцияМетаданных.Вставить("accountRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыБухгалтерии));
	КоллекцияМетаданных.Вставить("dataProc", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Обработки));
	КоллекцияМетаданных.Вставить("reports", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Отчеты));
	КоллекцияМетаданных.Вставить("enums", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Перечисления));
	КоллекцияМетаданных.Вставить("commonModules", ОписатьОбщиеМодули(Метаданные.ОбщиеМодули));
	КоллекцияМетаданных.Вставить("сhartsOfAccounts", ОписатьКоллекциюОбъектовМетаданых(Метаданные.ПланыСчетов));
	КоллекцияМетаданных.Вставить("businessProcesses", ОписатьКоллекциюОбъектовМетаданых(Метаданные.БизнесПроцессы));
	КоллекцияМетаданных.Вставить("tasks", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Задачи));
	КоллекцияМетаданных.Вставить("exchangePlans", ОписатьКоллекциюОбъектовМетаданых(Метаданные.ПланыОбмена));
	КоллекцияМетаданных.Вставить("chartsOfCharacteristicTypes", ОписатьКоллекциюОбъектовМетаданых(Метаданные.ПланыВидовХарактеристик));	
	КоллекцияМетаданных.Вставить("chartsOfCalculationTypes", ОписатьКоллекциюОбъектовМетаданых(Метаданные.ПланыВидовРасчета));	
	
	Файл = Новый ЗаписьJSON();
	Файл.УстановитьСтроку();
	Попытка
		ЗаписатьJSON(Файл, КоллекцияМетаданных);
	Исключение
		ВызватьИсключение("Не удалось сохранить коллекцию метаданных:" + Символы.ПС + ОписаниеОшибки());
	КонецПопытки;
	
	ЗначениеКоллекции = Файл.Закрыть();
	
	Адрес = ?(АдресРезультата <> Неопределено, АдресРезультата, Новый УникальныйИдентификатор());
	
	АдресРезультата = ПоместитьВоВременноеХранилище(ЗначениеКоллекции, Адрес);
	
	Возврат АдресРезультата;
	
КонецФункции

Функция ОписатьКоллекциюОбъектовМетаданых(Коллекция)
	
	ОписаниеКоллекции = Новый Структура();
	
	Для НомерОбъекта = 0 По Коллекция.Количество() - 1 Цикл
		
		ОписаниеРеквизитов = Новый Структура();
		ОписаниеПредопределенных = Новый Структура();
		
		ОбъектМетаданных = Коллекция.Получить(НомерОбъекта);
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Если ИмяМетаданных(ПолноеИмя) = "Перечисление" Тогда
			
			Для НомерРеквизита = 0 По ОбъектМетаданных.ЗначенияПеречисления.Количество() - 1 Цикл
				Реквизит = ОбъектМетаданных.ЗначенияПеречисления.Получить(НомерРеквизита);
				ОписаниеРеквизитов.Вставить(Реквизит.Имя, Новый Структура("name", Реквизит.Синоним));
			КонецЦикла;
			
		Иначе
			
			Для НомерРеквизита = 0 По ОбъектМетаданных.Реквизиты.Количество() - 1 Цикл
				Реквизит = ОбъектМетаданных.Реквизиты.Получить(НомерРеквизита);
				ДобавитьОписаниеРеквизита(ОписаниеРеквизитов, Реквизит, Истина);
			КонецЦикла;
			
			Если ОбъектМетаданныхИмеетСтандартныеРеквизиты(ПолноеИмя) Тогда
					
				Для Каждого Реквизит ИЗ ОбъектМетаданных.СтандартныеРеквизиты Цикл
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетПредопределенные(ПолноеИмя) Тогда
					
				Предопределенные = ОбъектМетаданных.ПолучитьИменаПредопределенных();
				
				Для Каждого Имя ИЗ Предопределенные Цикл
					ОписаниеПредопределенных.Вставить(Имя, "");
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетИзмерения(ПолноеИмя) Тогда
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.Измерения.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.Измерения.Получить(НомерРеквизита);
					ДобавитьОписаниеРеквизита(ОписаниеРеквизитов, Реквизит, Истина);
				КонецЦикла;
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.Ресурсы.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.Ресурсы.Получить(НомерРеквизита);
					ДобавитьОписаниеРеквизита(ОписаниеРеквизитов, Реквизит, Ложь);
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетТЧ(ПолноеИмя) Тогда
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.ТабличныеЧасти.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.ТабличныеЧасти.Получить(НомерРеквизита);
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, Новый Структура("name", "ТЧ: " + Реквизит.Синоним));
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЕсли;
		
		СтруктураОбъекта = Новый Структура("properties", ОписаниеРеквизитов);
		Если 0 < ОписаниеПредопределенных.Количество() Тогда
			СтруктураОбъекта.Вставить("predefined", ОписаниеПредопределенных); 
		КонецЕсли;
		
		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, СтруктураОбъекта);
		
	КонецЦикла;
	
	Возврат ОписаниеКоллекции;
	
КонецФункции

Функция ОписатьОбщиеМодули(Коллекция)
	
	ОписаниеКоллекции = Новый Структура();
	
	Для НомерОбъекта = 0 По Коллекция.Количество() - 1 Цикл
		ОбъектМетаданных = Коллекция.Получить(НомерОбъекта);
		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, Новый Структура());
	КонецЦикла;
	
	Возврат ОписаниеКоллекции
	
КонецФункции

Функция ИмяМетаданных(ПолноеИмя)
	
	Возврат СтрПолучитьСтроку(СтрЗаменить(ПолноеИмя, ".", Символы.ПС), 1);
	
КонецФункции

Процедура ДобавитьОписаниеРеквизита(ОписаниеРеквизитов, Реквизит, ПолучатьСвязиРеквизита)
	
	
	ОпределятьСвязи = Истина;
	// Если поменять на Ложь, то получение структуры метаданных будет происходить примерно в 2 раза быстрее,
	// но не будет работать подсказка через . для реквизитов ссылочного типа
	
	Связь = ?(ОпределятьСвязи И ПолучатьСвязиРеквизита, ПолучитьСвязьСОбъектомМетаданных(Реквизит), "");
	
	ОписаниеРеквизита = Новый Структура("name", Реквизит.Синоним);
	
	Если ЗначениеЗаполнено(Связь) Тогда
		ОписаниеРеквизита.Вставить("ref", Связь);
	КонецЕсли;
	
	ОписаниеРеквизитов.Вставить(Реквизит.Имя, ОписаниеРеквизита);
	
КонецПроцедуры

Функция ОбъектМетаданныхИмеетСтандартныеРеквизиты(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("Документ");
	Объекты.Добавить("БизнесПроцесс");
	Объекты.Добавить("Задача");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

Функция ОбъектМетаданныхИмеетПредопределенные(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("ПланСчетов");	
	Объекты.Добавить("ПланВидовХарактеристик");
	Объекты.Добавить("ПланВидовРасчета");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

Функция ОбъектМетаданныхИмеетИзмерения(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("РегистрСведений");
	Объекты.Добавить("РегистрНакопления");
	Объекты.Добавить("РегистрБухгалетрии");
	Объекты.Добавить("РегистрРасчета");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

Функция ОбъектМетаданныхИмеетТЧ(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("Документ");
	Объекты.Добавить("Отчет");
	Объекты.Добавить("Обработка");
	Объекты.Добавить("БизнесПроцесс");
	Объекты.Добавить("Задача");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

Функция ПолучитьСвязьСОбъектомМетаданных(Реквизит)
	
	Связь = "";
	Связи = Новый Соответствие();
	
	Типы = Реквизит.Тип.Типы();
	
	Индекс = 0;
	
	Пока Индекс < Типы.Количество() И НЕ ЗначениеЗаполнено(Связь) Цикл
	
		Тип = Типы[Индекс];
		
		СвязьТипа = Связи[Тип];
		
		Если СвязьТипа = Неопределено Тогда
			
			ОбъектМетаданных = Метаданные.НайтиПоТипу(Тип);
			
			Если ОбъектМетаданных <> Неопределено Тогда
				
				// Сейчас связи описыватьются только для справочников и документов.
				// При желании, пожертвовав скоростью получения описания всех метаданных
				// сюда же можно добавить следующие элементы:
				// Метаданные.БизнесПроцессы businessProcesses
				// Метаданные.Задачи tasks
				// Метаданные.ПланыВидовРасчета chartsOfCalculationTypes
				// Метаданные.ПланыВидовХарактеристик chartsOfCharacteristicTypes
				// Метаданные.ПланыОбмена exchangePlans
				// Метаданные.ПланыСчетов сhartsOfAccounts
				Если Метаданные.Справочники.Содержит(ОбъектМетаданных) Тогда
					Связь = "catalogs." + ОбъектМетаданных.Имя;
				ИначеЕсли Метаданные.Документы.Содержит(ОбъектМетаданных) Тогда
					Связь = "documents." + ОбъектМетаданных.Имя;
				КонецЕсли;
				
			КонецЕсли;
			
			Связи[Тип] = Связь;
			
		Иначе
			
			Связь = СвязьТипа;
			
		КонецЕсли;
		
		Индекс = Индекс + 1;
		
	КонецЦикла;
	
	Возврат Связь;
	
КонецФункции
