#include "code\holidays.dm"
#include "code\items.dm"
#include "code\structures.dm"

/datum/modpack/lgbt_removal
	id = "lgbt_removal"
	name = "Убираем ЛГБТ контент"
	group = "Tweaks"
	desc = "Заменяем значки на нейтральные (флаги стран). Убираем неопределённый пол (Их и Оно), и убираем выбор тип тела"
	author = "Artemchik542 (Код), bee (Спрайты), SS220 (Выбор пола)"


// если вдруг заходите убрать выбор пола на неправильные, то вот пиары (не примены полностью в билде)
//(https://github.com/ss220club/Bandastation/pull/339)
//https://github.com/ss220club/BandaStation/pull/1360
