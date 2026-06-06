/// Sends the target a fake adminhelp sound
/datum/smite/fake_bwoink
	name = "Fake bwoink"

/datum/smite/fake_bwoink/effect(client/user, mob/living/target)
	. = ..()
	SEND_SOUND(target, 'sound/effects/adminhelp.ogg')

/datum/smite/fake_discord
	name = "Fake discord ping"

/datum/smite/fake_discord/effect(client/user, mob/living/target)
	. = ..()
	SEND_SOUND(target, 'sound/effects/discord.ogg')
