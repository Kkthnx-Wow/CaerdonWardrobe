local ADDON_NAME, namespace = ...
local L = namespace.L

local addonName = 'WorldQuestTab'
local Version = nil
if select(4, GetAddOnInfo(addonName)) then
	if IsAddOnLoaded(addonName) then
	    Version = GetAddOnMetadata(addonName, 'Version')
	    CaerdonWardrobe:RegisterAddon(addonName, {
	    	isBag = false
	    })
	end
end

if Version then

	local options = {
		iconOffset = 4,
		iconSize = 30,
		overridePosition = "TOPLEFT",
		itemCountOffset = 10,
		bindingScale = 0.9
	}

	local function RefreshButtons()
		local buttons = WQT_WorldQuestFrame.ScrollFrame.buttons;
		for i = 1, #buttons do
			local button = buttons[i]
			UpdateButton(button)
		end
	end

	local function IsValidItem(type)
	  return
      type == WQT_REWARDTYPE.weapon or
      type == WQT_REWARDTYPE.equipment or 
      type == WQT_REWARDTYPE.spell or 
      type == WQT_REWARDTYPE.item
	end

	local function UpdateButton(button)
    local questInfo = button.info
    local rewardSlot = 1
    if questInfo and questInfo.isValid then
      if questInfo.reward.id and IsValidItem(questInfo.reward.type) then
        button.Reward.count = questInfo.reward.amount
        CaerdonWardrobe:UpdateButton(questInfo.reward.id, "QuestButton", { itemID = questInfo.reward.id, questID = button.questId }, button.Reward, options)
      else
        button.Reward.count = 0
        CaerdonWardrobe:ClearButton(button.Reward)
      end
    else
      CaerdonWardrobe:ClearButton(button.Reward)
    end
	end

	WQT_WorldQuestFrame:RegisterCallback('ListButtonUpdate', UpdateButton)

	-- hooksecurefunc(WQT_QuestScrollFrame, 'DisplayQuestList', RefreshButtons)
end
