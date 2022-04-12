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