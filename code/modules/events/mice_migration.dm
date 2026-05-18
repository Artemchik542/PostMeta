/datum/round_event_control/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	weight = 10
	category = EVENT_CATEGORY_ENTITIES
	description = "A horde of mice arrives, and perhaps even the Rat King themselves."

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("космо-зимой", "урезанием сечения проводов", "нашествием Татаро-монгольского иго", //MASSMETA TRANSLATION
		"похолоданием космоса", "\[ДАННЫЕ УДАЛЕНЫ\]", "резким дрейфом микроклимата на станции",
		"тем что карты легли плохо")
	var/plural = pick("неимоверное количество", "орда", "полчище", "колония",
		"стая", "всего-то [maximum_mice]")
	var/name = pick("грузунов", "мышей", "пищащих комочков",
		"поглотителей изоляции", "\[ДАННЫЕ УДАЛЕНЫ\]", "энергитических паразитов")
	var/movement = pick("мигрировали", "устремились", "обратились в бегство", "пробрались")
	var/location = pick("технические тоннели", "технические помещения",
		"\[ДАННЫЕ УДАЛЕНЫ\]", "склады с проводами")

	priority_announce("В связи с [cause], [plural] [name] [movement] \
		в [location].", "Оповещение о миграции",
		'sound/mobs/non-humanoids/mouse/mousesqueek.ogg')

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
