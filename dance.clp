(deffunction member (?item $?list)
   (if (lexemep ?item)
      then (bind ?item (lowcase ?item)))
   (member$ ?item ?list))


(deffunction ask-question (?question $?allowed-values)
	(printout t ?question)
	(bind ?answer (read))
	(if (lexemep ?answer)
		then (bind ?answer (lowcase ?answer)))
	(while (not (member ?answer ?allowed-values)) do
		(printout t ?question)
		(bind ?answer (read))
		(if (lexemep ?answer)
			then (bind ?answer (lowcase ?answer))))
	?answer)


(deffunction yes-or-no-p (?question)
	(bind ?response (ask-question ?question yes no y n))
	(if (or (eq ?response yes) (eq ?response y))
		then yes
	else no))


(defrule system-banner ""
(declare (salience 0)) =>
(printout t crlf crlf))
(defrule print-repair ""
(declare (salience 0))
(repair ?item) =>
(printout t crlf crlf)
(printout t "Стиль танца, который вас интересует: ")
(printout t)
(format t "%s%n%n" ?item))

; 0  
(defrule determine-zero-question ""
(not (century ?))
(not (repair ?)) =>
(assert (century (yes-or-no-p "Стиль танца зародился до XX века? (y/n): "))))

; +1 
(defrule determine-geometry ""
(century yes)
(not (repair ?)) =>
(assert (geometry(yes-or-no-p "Для этого стиля характерна геометрическая ясность (позиции рук, ног, корпуса)? (y/n): "))))

; ++2 
(defrule determine-couple ""
(geometry yes)
(not (repair ?)) =>
(assert (couple(yes-or-no-p "Танец обязательно исполняется в паре? (y/n): "))))

; ++-3 
(defrule determine-jump ""
(couple no)
(not (repair ?)) =>
(assert (jump(yes-or-no-p "В танце преобладают прыжки? (y/n): "))))

; +-2  
(defrule determine-east ""
(geometry no)
(not (repair ?)) =>
(assert (east(yes-or-no-p "Этот стиль зарождался на востоке?  (y/n): "))))

; -1 
(defrule determine-drama ""
(century no)
(not (repair ?)) =>
(assert (drama(yes-or-no-p "Для стиля характерно драматургическое построение? (y/n): "))))

; -+2  
(defrule determine-philosophy ""
(drama yes)
(not (repair ?)) =>
(assert (philosophy(yes-or-no-p "Постановка в этом стиле носит философский характер? (y/n): "))))

; -++3 
(defrule determine-classic ""
(philosophy yes)
(not (repair ?)) =>
(assert (classic (yes-or-no-p "Стиль основан на классическом танце? (y/n): "))))

; -+-3 
(defrule determine-otherstyles ""
(philosophy no)
(not (repair ?)) =>
(assert (otherstyles (yes-or-no-p "Может ли этот стиль сочетать в себе другие стили? (y/n): "))))

; --2  
(defrule determine-female ""
(drama no)
(not (repair ?)) =>
(assert (female(yes-or-no-p "Этот стиль женский? (y/n): ")))) 

; --+3 
(defrule determine-pylon ""
(female yes)
(not (repair ?)) =>
(assert (pylon (yes-or-no-p "Для этого стиля требуется пилон? (y/n): "))))

; --++4
(defrule determine-acrobaticelement ""
(pylon yes)
(not (repair ?)) =>
(assert (acrobaticelement (yes-or-no-p "В этом стиле присутствуют акробатические элементы? (y/n): "))))

; --+-4 
(defrule determine-heels ""
(pylon no)
(not (repair ?)) =>
(assert (heels (yes-or-no-p "Хореография исполняется на каблуках? (y/n): "))))

(defrule determine-clearly ""
(female no)
(not (repair ?)) =>
(assert (clearly (yes-or-no-p "Для этого стиля характерны четкие движения? (y/n): "))))

; —++4 
(defrule determine-pose ""
(clearly yes)
(not (repair ?)) =>
(assert (pose (yes-or-no-p "Акцент в танце делается на позы? (y/n): "))))

; ---++5
(defrule determine-model ""
(pose yes)
(not (repair ?)) =>
(assert (model (yes-or-no-p "Стиль танца базируется на модельных позах? (y/n): "))))

; —+-5
(defrule determine-robot ""
(pose no)
(not (repair ?)) =>
(assert (robot (yes-or-no-p "Движения этого стиля напоминают движения робота? (y/n): "))))

; ----4 
(defrule determine-hiphop ""
(clearly no)
(not (repair ?)) =>
(assert (hiphop (yes-or-no-p "Связан ли этот стиль с культурой хип-хоп? (y/n): "))))

; ——+5
(defrule determine-trick ""
(hiphop yes)
(not (repair ?)) =>
(assert (trick (yes-or-no-p "Характерны ли для этого стиля акробатические трюки? (y/n): "))))

; ——5
(defrule determine-hip ""
(hiphop no)
(not (repair ?)) =>
(assert (hip (yes-or-no-p "В стиле активно используется работа бедер и ягодиц? (y/n): "))))


(defrule couple-yes ""
(couple yes)
(not (repair ?)) =>
(assert (repair "Спортивные бальные танцы")))

(defrule jump-no ""
(jump no)
(not (repair ?)) =>
(assert (repair "Женский классический танец")))
(defrule jump-yes ""
(jump yes)
(not (repair ?)) =>
(assert (repair "Мужской классический танец")))

(defrule east-no ""
(east no)
(not (repair ?)) =>
(assert (repair "Народные танцы")))
(defrule east-yes ""
(east yes)
(not (repair ?)) =>
(assert (repair "Восточные танцы")))

(defrule classic-no ""
(classic no)
(not (repair ?)) =>
(assert (repair "Контемп")))
(defrule classic-yes ""
(classic yes)
(not (repair ?)) =>
(assert (repair "Модерн")))

(defrule otherstyles-no ""
(otherstyles no)
(not (repair ?)) =>
(assert (repair "Джаз")))
(defrule otherstyles-yes ""
(otherstyles yes)
(not (repair ?)) =>
(assert (repair "Эстрадный танец")))

(defrule acrobaticelement-no ""
(acrobaticelement no)
(not (repair ?)) =>
(assert (repair "Стрип-платика")))
(defrule acrobaticelement-yes ""
(acrobaticelement yes)
(not (repair ?)) =>
(assert (repair "Акробатика на пилоне")))

(defrule heels-no ""
(heels no)
(not (repair ?)) =>
(assert (repair "Джаз-фанк")))
(defrule heels-yes ""
(heels yes)
(not (repair ?)) =>
(assert (repair "Хай-хиллс")))

(defrule model-no ""
(model no)
(not (repair ?)) =>
(assert (repair "Тектоник")))
(defrule model-yes ""
(model yes)
(not (repair ?)) =>
(assert (repair "Вог")))

(defrule robot-no ""
(robot no)
(not (repair ?)) =>
(assert (repair "Локинг")))
(defrule robot-yes ""
(robot yes)
(not (repair ?)) =>
(assert (repair "Поппинг")))

(defrule trick-no ""
(trick no)
(not (repair ?)) =>
(assert (repair "Хип-хоп")))
(defrule trick-yes ""
(trick yes)
(not (repair ?)) =>
(assert (repair "Брэйк-данс")))

(defrule hip-no ""
(hip no)
(not (repair ?)) =>
(assert (repair "Дэнсхолл")))
(defrule hip-yes ""
(hip yes)
(not (repair ?)) =>
(assert (repair "Тверк")))