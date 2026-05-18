#define CANCEL_FAKE_ALERT -1

/datum/hallucination/station_message
	abstract_hallucination_parent = /datum/hallucination/station_message
	random_hallucination_weight = 1
	hallucination_tier = HALLUCINATION_TIER_RARE
	/// if TRUE, skip on deaf hallucinators
	var/require_hearing = TRUE

/datum/hallucination/station_message/start()
	if(require_hearing && HAS_TRAIT(hallucinator, TRAIT_DEAF))
		return FALSE
	if(do_fake_alert() == CANCEL_FAKE_ALERT)
		return FALSE

	qdel(src) // To be implemented by subtypes, call parent for easy cleanup
	return TRUE

/datum/hallucination/station_message/proc/do_fake_alert()
	return CANCEL_FAKE_ALERT

/datum/hallucination/station_message/blob_alert
	require_hearing = TRUE

/datum/hallucination/station_message/blob_alert/do_fake_alert()
	priority_announce("Подтвержден 5 уровень биологической угрозы на [station_name()]. Весь персонал должен ликвидировать очаг заболевания.", \
		"Биологическая угроза", ANNOUNCER_OUTBREAK5, players = list(hallucinator))

/datum/hallucination/station_message/shuttle_dock

/datum/hallucination/station_message/shuttle_dock/do_fake_alert()
	priority_announce(
		text = "[SSshuttle.emergency] пристыковался со станцией. У вас есть [DisplayTimeText(SSshuttle.emergency_dock_time)] чтобы войти на борт эвакуационного шаттла.",
		title = "Прибытие эвакуационного шаттла",
		sound = ANNOUNCER_SHUTTLEDOCK,
		sender_override = "Emergency Shuttle Uplink Alert",
		players = list(hallucinator),
		color_override = "orange",
	)

/datum/hallucination/station_message/malf_ai
	require_hearing = TRUE

/datum/hallucination/station_message/malf_ai/do_fake_alert()
	if(!(locate(/mob/living/silicon/ai) in GLOB.silicon_mobs))
		return CANCEL_FAKE_ALERT

	priority_announce("Во всех системах станции обнаружены зловреды в средах исполнения инструкций. Незамедлительно отключите свой ИИ, чтобы предотвратить возможное повреждение его ядер совести и гумманости.", \
		"Угроза Аномалий", ANNOUNCER_AIMALF, players = list(hallucinator))

/datum/hallucination/station_message/heretic
	require_hearing = TRUE
	/// This is gross and will probably easily be outdated in some time but c'est la vie.
	/// Maybe if someone datumizes heretic paths or something this can be improved
	var/static/list/ascension_bodies = list(
		list(
			"text" = "Бойтесь пламени, ибо Повелитель Пепла, %FAKENAME%, вознесся! Пламя поглотит всё!",
			"sound" = 'sound/music/antag/heretic/ascend_blade.ogg',
		),
		list(
			"text" = "Мастер клинков %FAKENAME% ученик Чемпиона Растерзаний, вознесся! Их сталь — та, что рассечет реальность в посеребряном шторме!",
			"sound" = 'sound/music/antag/heretic/ascend_blade.ogg',
		),
		list(
			"text" = "Навечно закрученный вихрь. Реальность раскрылась. С РАСПРОСТЕРТЫМИ РУКАМИ ГОСПОДИН НОЧИ, %FAKENAME%, вознесся! Бойтесь вечно извивающейся руки!",
			"sound" = 'sound/music/antag/heretic/ascend_flesh.ogg',
		),
		list(
			"text" = "Бойтесь коррозии, ибо Приносящий ржавчину, %FAKENAME%, вознесся! Никто не уйдет от окисления!",
			"sound" = 'sound/music/antag/heretic/ascend_rust.ogg',
		),
		list(
			"text" = "Прибыл джентльмен из пустоты %FAKENAME%, шагая по вальсу, что положит конец мирам!",
			"sound" = 'sound/music/antag/heretic/ascend_void.ogg',
		)
	)

/datum/hallucination/station_message/heretic/do_fake_alert()
	// Unfortunately, this will not be synced if mass hallucinated
	var/mob/living/carbon/human/totally_real_heretic = random_non_sec_crewmember()
	if(!totally_real_heretic)
		return CANCEL_FAKE_ALERT

	var/list/fake_ascension = pick(ascension_bodies)
	var/announcement_text = replacetext(fake_ascension["text"], "%FAKENAME%", totally_real_heretic.real_name)
	priority_announce(
		text = "[generate_heretic_text()] [announcement_text] [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = fake_ascension["sound"],
		players = list(hallucinator),
		color_override = "pink",
	)

/datum/hallucination/station_message/cult_summon
	require_hearing = TRUE

/datum/hallucination/station_message/cult_summon/do_fake_alert()
	// Same, will not be synced if mass hallucinated
	var/mob/living/carbon/human/totally_real_cult_leader = random_non_sec_crewmember()
	if(!totally_real_cult_leader)
		return CANCEL_FAKE_ALERT

	// Get a fake area that the summoning is happening in
	var/area/hallucinator_area = get_area(hallucinator)
	var/area/fake_summon_area_type = pick(GLOB.the_station_areas - hallucinator_area.type)
	var/area/fake_summon_area = GLOB.areas_by_type[fake_summon_area_type]

	priority_announce(
		text = "Некий [totally_real_cult_leader.real_name] призывает существ из иного измерения в [fake_summon_area]. Прервите ритуал любой ценой!",
		title = "[command_name()] по вопросам высших измерений",
		sound = 'sound/music/antag/bloodcult/bloodcult_scribe.ogg',
		has_important_message = TRUE,
		players = list(hallucinator),
	)

/datum/hallucination/station_message/meteors
	random_hallucination_weight = 2
	require_hearing = TRUE

/datum/hallucination/station_message/meteors/do_fake_alert()
	priority_announce("Обнаружены метеориты, летящие по траектории столкновения со станцией.", "Угроза метеоритов", ANNOUNCER_METEORS, players = list(hallucinator))

/datum/hallucination/station_message/supermatter_delam

/datum/hallucination/station_message/supermatter_delam/do_fake_alert()
	SEND_SOUND(hallucinator, 'sound/effects/magic/charge.ogg')
	to_chat(hallucinator, span_bolddanger("You feel reality distort for a moment..."))

/datum/hallucination/station_message/clock_cult_ark
	// Clock cult's long gone, but this stays for posterity.
	random_hallucination_weight = 0

/datum/hallucination/station_message/clock_cult_ark/start()
	hallucinator.playsound_local(hallucinator, 'sound/machines/clockcult/ark_deathrattle.ogg', 50, FALSE, pressure_affected = FALSE)
	hallucinator.playsound_local(hallucinator, 'sound/effects/clockcult_gateway_disrupted.ogg', 50, FALSE, pressure_affected = FALSE)
	addtimer(CALLBACK(src, PROC_REF(play_distant_explosion_sound)), 2.7 SECONDS)
	return TRUE // does not call parent to finish up the sound in a few seconds

/datum/hallucination/station_message/clock_cult_ark/proc/play_distant_explosion_sound()
	if(QDELETED(src))
		return

	hallucinator.playsound_local(get_turf(hallucinator), 'sound/effects/explosion/explosion_distant.ogg', 50, FALSE, pressure_affected = FALSE)
	qdel(src)

#undef CANCEL_FAKE_ALERT
