--EFFECTS--
function medicine.register_effect_type(effect_type_id, description, icon, groups, apply, cancel, hidden, cancel_on_death, repeat_interval)
	local effect_type = {}
	effect_type.description = description
	effect_type.apply = apply
	effect_type.groups = groups
	effect_type.icon = icon
	if cancel ~= nil then
		effect_type.cancel = cancel
	else
		effect_type.cancel = function() end
	end
	if hidden ~= nil then
		effect_type.hidden = hidden
	else
		effect_type.hidden = false
	end
	if cancel_on_death ~= nil then
		effect_type.cancel_on_death = cancel_on_death 
	else
		effect_type.cancel_on_death = true
	end
	effect_type.repeat_interval = repeat_interval

	playereffects.effect_types[effect_type_id] = effect_type
	minetest.log("action", "[medicine] Effect type "..effect_type_id.." registered!")
end

medicine.register_effect_type("poisoning", "Poisoning", nil, {},
	function(player)
		local hudid = player:hud_add({
			hud_elem_type = "image",
			position = { x=0.5, y=0.5 },
			scale = { x=-100, y=-100 },
			text = "poisonous_heart.png",
		})
		if(hudid ~= nil) then
			return { hudid = hudid }
		else
			minetest.log("error", "[medicine] [examples] The effect \"Poisoning\" could not be applied. The call to hud_add(...) failed.")
			return false
		end
	end,
	function(effect, player)
		player:hud_remove(effect.metadata.hudid)
	end
)
