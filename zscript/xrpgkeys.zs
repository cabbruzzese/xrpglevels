class VillageKey : HexenKey
{
	Default
	{
		Inventory.Icon "KEYSLOTC";
		Inventory.PickupMessage "$TXT_KEY_VILLAGE";
	}
	States
	{
	Spawn:
		KEYC A -1;
		Stop;
	}
}

class SigilKey : HexenKey
{
	Default
	{
		Inventory.Icon "KEYSLOTD";
		Inventory.PickupMessage "$TXT_KEY_SIGIL";
	}
	States
	{
	Spawn:
		KEYD A -1;
		Stop;
	}
}