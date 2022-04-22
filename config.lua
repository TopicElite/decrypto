Config = {}

Config.MinWithdrawl = 400 -- $ received minimum for successful hack
Config.MaxWithdrawal = 500 -- $ received maximum for successful hack
Config.Account = "black_money" -- money | black_money | bank
Config.MingameBase = 10 -- 10 for decimal or 16 for hexadecimal
Config.MinigameTimeLimit = 100 -- time limit in seconds
Config.MingameAttemptLimit = 10 -- number of guesses allowed
Config.AddStress = 5 --% stress gain from hacking


Config.ATMModels = {
    `prop_atm_01`, -- 20 on map
    `prop_atm_02`, -- 37 on map
    `prop_atm_03`, -- 30 on map
    `prop_fleeca_atm` -- 4 on map
}

Config.ATMModelsString = {
    "prop_atm_01", -- 20 on map
    "prop_atm_02", -- 37 on map
    "prop_atm_03", -- 30 on map
    "prop_fleeca_atm" -- 4 on map
}

Config.Chance = 0.10 -- Chance of police alert on successful hack. Note: police are always alerted on failed hack.

