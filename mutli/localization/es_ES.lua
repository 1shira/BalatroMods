-- Localization by @kmiras, @panbimbogd, @themike_71
return {
	descriptions = {
		Joker = {
			j_broken = {
                name = "ERROR :(", -- The direct translation would be "ROTO" or "ROTA" but I see "ERROR :(" better | La traducción directa sería "ROTO" o "ROTA" pero veo mejor "ERROR :("
				text = {
					"Esta carta está rota o no está",
                    "implementada en la versión actual",
                    "de un mod que estás usando.",
				},
			},
			j_mp_defensive_joker = {
                name = "Comodín defensivo",
                text = {
                    "{C:chips}+#1#{} Fichas por cada {C:red,E:1}vida{}",
                    "menos que tu {X:purple,C:white}Némesis{}",
                    "{C:inactive}(Actualmente {C:chips}+#2#{C:inactive} Fichas)",
                },
            },
			j_mp_skip_off = {
                name = "Sálta-lo", -- Referring to the hopscotch game, the joker art (saltalo = jump it - skip-off) | Refiriéndose al juego de rayuela, el arte del comodín (saltalo = jump it - skip-off)
                text = {
                    "{C:blue}+#1#{} Manos y {C:red}+#2#{} Descartes",
                    "por cada {C:attention}ciega{} adicional omitida",
                    "comparado con tu {X:purple,C:white}Némesis{}",
                    "{C:inactive}(Actualmente {C:blue}+#3#{C:inactive}/{C:red}+#4#{C:inactive}, #5#)",
                },
            },
			j_mp_lets_go_gambling = {
                name = "Let's Go Gambling", -- It could be translated as "A jugar/apostar se ha dicho" in a different tone but I would leave it in English for the original meme | Podría traducirse como "A jugar/apostar se ha dicho" en un tono diferente pero lo dejaría en inglés por el meme original
                text = {
                    "{C:green}#1# en #2#{} probabilidades de",
                    "{X:mult,C:white}X#3#{} Multi y {C:money}$#4#{}",
                    "{C:green}#5# en #6#{} probabilidades de dar",
                    "a tu {X:purple,C:white}Némesis{} {C:money}$#7#",
                },
            },
			j_mp_speedrun = {
                name = "SPEEDRUN",
                text = {
                    "Si llegas a una {C:attention}Ciega PvP{}",
                    "antes que tu {X:purple,C:white}Némesis{},",
                    "crea una carta aleatoria {C:spectral}Espectral{}",
                    "{C:inactive}(Debe haber espacio)",
                },
            },
			j_mp_conjoined_joker = {
                name = "Comodín siamés",
                text = {
                    "Mientras estés en una {C:attention}Ciega PvP{}, gana",
                    "{X:mult,C:white}X#1#{} Multi por cada {C:blue}Mano{}",
                    "que le quede a tu {X:purple,C:white}Némesis{}",
                    "{C:inactive}(Máximo {X:mult,C:white}X#2#{C:inactive} Multi, Actualmente {X:mult,C:white}X#3#{C:inactive} Multi)",
                },
            },
            j_mp_penny_pincher = {
                name = "Tacaño",
                text = {
                    "Al inicio de la tienda, gana",
                    "{C:money}$#1#{} por cada {C:money}$#2#{}",
                    "que gastó tu {X:purple,C:white}Némesis{} en la última tienda",
                },
            },
            j_mp_taxes = {
                name = "Impuestos",
                text = {
                    "Cuando tu {X:purple,C:white}Némesis{} vende",
                    "una carta ganas {C:mult}+#1#{} Multi",
                    "{C:inactive}(Actualmente {C:mult}+#2#{C:inactive} Multi)",
                },
            },
            j_mp_magnet = {
                name = "Imán",
                text = {
                    "Después de {C:attention}#1#{} rondas,",
                    "vende esta carta para {C:attention}Copiar{}",
                    "el {C:attention}Comodín{} de mayor",
                    "valor de venta de tu {X:purple,C:white}Némesis{}",
                    "{C:inactive}(Actualmente {C:attention}#2#{C:inactive}/#3# rondas)",
                    "{C:inactive,s:0.8}(No copia el estado del Comodín)",
                },
            },
            j_mp_pizza = {
                name = "Pizza",
                text = {
                    "{C:red}+#1#{} Descartes para todos los jugadores",
                    "{C:red}-#2#{} Descarte cuando cualquier jugador",
                    "selecciona una ciega",
                    "Se consume cuando tu {X:purple,C:white}Némesis{} omite una ciega",
                },
            },
            j_mp_pacifist = {
                name = "Pacifista",
                text = {
                    "{X:mult,C:white}X#1#{} Multi mientras",
                    "no estés en una {C:attention}Ciega PvP{}",
                },
            },
			j_mp_hanging_chad = {
                name = "Papel perforado",
                text = {
                    "Reactiva la {C:attention}primera{} y {C:attention}segunda{}",
                    "carta jugada utilizada para puntuar",
                    "{C:attention}#1#{} vez adicional",
                },
            },
		},
		Planet = {
			c_mp_asteroid = {
                name = "Asteroide",
                text = {
                    "Disminuye #1# nivel de la",
                    "{C:legendary,E:1}mano de póker{}",
                    "de mayor nivel",
                    "de tu {X:purple,C:white}Némesis{}",
                },
            },
		},
		Blind = {
			bl_mp_nemesis = {
                name = "Tu Némesis",
                text = {
                    "Enfréntate a otro jugador,",
                    "quien tenga más fichas gana",
                },
            },
		},
		Edition = {
			e_mp_phantom = {
                name = "Fantasma",
                text = {
                    "{C:attention}Eterno{} y {C:dark_edition}Negativo{}",
                    "Creado y destruido por tu {X:purple,C:white}Némesis{}",
                },
            },
		},
		Enhanced = {
			m_mp_glass = {
                name = "Carta de vidrio",
                text = {
                    "{X:mult,C:white} X#1# {} Multi",
                    "{C:green}#2# en #3#{} probabilidades de",
                    "destruir la carta",
                },
            },
		},
		Other = {
			current_nemesis = {
                name = "Némesis",
                text = {
                    "{X:purple,C:white}#1#{}",
                    "Tu único y verdadero Némesis",
                },
            },
		},
	},
	misc = {
		labels = {
            mp_phantom = "Fantasma",
        },
        challenge_names = {
            c_mp_standard = "Estándar",
            c_mp_badlatro = "Badlatro",
            c_mp_tournament = "Torneo",
            c_mp_weekly = "Semanal",
            c_mp_vanilla = "Vanilla",
        },
		dictionary = {
			b_singleplayer = "Un jugador",
			b_join_lobby = "Unirse a la Sala",
			b_return_lobby = "Volver a la Sala",
			b_reconnect = "Reconectarse",
			b_create_lobby = "Crear Sala",
			b_start_lobby = "Iniciar Sala",
			b_ready = "Listo",
			b_unready = "No Listo",
			b_leave_lobby = "Salir de la Sala",
			b_mp_discord = "Servidor de Discord de Balatro Multiplayer",
			b_start = "INICIAR",
			b_wait_for_host_start = { "ESPERANDO A", "QUE EL ANFITRIÓN INICIE" },
			b_wait_for_players = { "ESPERANDO A", "JUGADORES" },
			b_lobby_options = "OPCIONES DE LA SALA",
			b_copy_clipboard = "Copiar al portapapeles",
			b_view_code =  "VER CÓDIGO",
			b_leave = "SALIR",
			b_opts_cb_money = "Recibe $ al perder una vida como ayuda para remontar",
			b_opts_no_gold_on_loss = "No recibes recompensas de la ciega PvP al perder la ronda",
			b_opts_death_on_loss = "Pierdes una vida al perder una ronda que no sea PvP",
			b_opts_start_antes = "Apuestas Iniciales",
			b_opts_diff_seeds = "Los jugadores tienen códigos diferentes",
			b_opts_lives = "Vidas",
			b_opts_multiplayer_jokers = "Habilitar cartas multijugador",
			b_opts_player_diff_deck = "Los jugadores tienen diferentes Mazos",
			b_reset = "Reiniciar",
			b_set_custom_seed = "Establecer código personalizado",
			b_mp_kofi_button = "Apoyarme en Ko-fi",
            b_unstuck = "Desatascar",
            b_unstuck_arcana = "Atascado en el paquete potenciador",
            b_unstuck_blind = "Atascado fuera del PvP",
        	k_enemy_score = "Puntuación actual del enemigo",
			k_enemy_hands = "Manos restantes del enemigo: ",
			k_coming_soon = "¡Próximamente!",
			k_wait_enemy = "Esperando a que el enemigo acabe...",
			k_lives = "Vidas",
			k_lost_life = "Pierde una vida",
			k_total_lives_lost = " Vidas Totales perdidas (4$ cada una)", -- Should that space be there? | ¿Ese espacio debe estar ahí?
			k_attrition_name = "Desgaste",
			k_enter_lobby_code = "Introducir código de sala",
			k_paste = "Pegar desde el portapapeles",
			k_username = "Nombre de usuario:",
			k_enter_username = "Introduce tu nombre de usuario",
			k_join_discord = "Entra en el ",
			k_discord_msg = "Allí puedes reportar bugs y encontrar personas con las que jugar",
			k_enter_to_save = "Presiona INTRO para guardar",
			k_in_lobby = "En la Sala",
			k_connected = "Conectado al servicio",
			k_warn_service = "ADVERTENCIA: No se ha podido encontrar el servicio multijugador",
			k_set_name = "¡Especifica tu nombre de usuario en el menú principal! (Mods > Multiplayer > Configuración)",
			k_mod_hash_warning = "¡Los jugadores tienen diferentes mods o diferentes versiones de mods! ¡Esto puede causar problemas!",
			k_lobby_options = "Opciones de la Sala",
			k_connect_player = "Jugadores conectados:",
			k_opts_only_host = "Solo el anfitrión puede cambiar estas opciones",
			k_opts_gm = "Modificadores de juego",
			k_bl_life = "Vida",
			k_bl_or = "o",
			k_bl_death = "Muerte",
			k_current_seed = "Código actual: ",
			k_random = "Aleatorio", -- It can also be left as is, "Random" | También puede dejarse como es, "Random"
			k_standard = "Estándar",
			k_standard_description = "El conjunto de reglas estándar, incluye cartas multijugador y cambios al juego base para adaptarse a la estrategia del multijugador.",
			k_vanilla = "Vanilla",
			k_vanilla_description = "El conjunto de reglas clásico, sin cartas multijugador, sin modificaciones al contenido del juego base.",
			k_weekly = "Semanal",
			k_weekly_description = "Un conjunto de reglas especial que cambia semanal o quincenalmente. ¡Supongo que tendrás que descubrir de qué se trata! Actualmente: ",
			k_tournament = "Torneo",
			k_tournament_description = "El conjunto de reglas de torneo, es igual que el conjunto de reglas estándar pero no permite cambiar las opciones de la sala.",
			k_badlatro = "Badlatro",
			k_badlatro_description = "Un conjunto de reglas semanal diseñado por @dr_monty_the_snek en el servidor de Discord que ha sido añadido al mod de forma permanente.",
			k_oops_ex = "Oops!", -- Maybe as "¡Vaya!" but not bad as is | Quizás como "¡Vaya!" pero no está mal tal cual
			ml_enemy_loc = { "Ubicación del", "enemigo" },
			ml_mp_kofi_message = {
				"Este mod y servidor es",
                "desarrollado y mantenido por ",
                "una persona, sí",
                "te gusta, considera",
			},
			loc_ready = "Listo para el PvP",
			loc_selecting = "Seleccionando una ciega",
			loc_shop = "Comprando",
			loc_playing = "Jugando ",
		},
		v_dictionary = {
			a_mp_art = { "Arte: #1#" },
			a_mp_code = { "Código: #1#" },
			a_mp_idea = { "Idea: #1#" },
			a_mp_skips_ahead = { "#1# Ciegas por delante" },
			a_mp_skips_behind = { "#1# Ciegas por detrás" },
			a_mp_skips_tied = { "Empatado" },
		},
		v_text = {
			ch_c_hanging_chad_rework = { "El {C:attention}Papel perforado{} está {C:dark_edition}modificado" },
			ch_c_glass_cards_rework = { "Las {C:attention}Cartas de vidrio{} están {C:dark_edition}modificadas" },
		},
	},
}
