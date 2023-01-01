const JUGG_CHARGE_SPEED =13.;

class XRpgJuggernaut : actor
{
  int chargeAttempt;
  Default
  {
    Health 1000;
    PainChance 16;
    Speed 12;
    Radius 30;
    Height 56;
    Mass 1000;
    Meleerange 72;
    Monster;
    +FLOORCLIP
    SeeSound "Juggernaut/Sight";
    PainSound "juggernaut/pain";
    DeathSound "juggernaut/death";
    Obituary "%o was pummeled by a juggernaut.";
    Damage 18;

    MaxTargetRange 8*64;
  }
  
  States
  {
    Spawn:
      JUGG AB 10 A_Look;
      Loop;
    See:
      JUGG A 3 A_Chase;
      JUGG A 0 A_StartSound ("Juggernaut/Step");
      JUGG A 3 A_Chase;
      JUGG BB 3 A_Chase;
      JUGG C 3 A_Chase;
      JUGG C 0 A_StartSound ("Juggernaut/Step");
      JUGG C 3 A_Chase;
      JUGG DD 3 A_Chase;
      Loop;
    Melee:
      JUGG EF 4 A_FaceTarget;
      JUGG G 4 A_FaceTarget;
      JUGG G 0 A_StartSound ("Juggernaut/Attack");
      JUGG G 0 A_StartSound ("Juggernaut/Pain");
      JUGG H 8 A_CustomMeleeAttack (25, "Juggernaut/Hit", "", "", 1);
      JUGG I 4 A_FaceTarget;
      JUGG I 0 A_StartSound ("Juggernaut/Attack");
      JUGG I 0 A_StartSound ("Juggernaut/Pain");
      JUGG J 8 A_CustomMeleeAttack (25, "Juggernaut/Hit", "", "", 1);
      Goto See;
    Missile:
      JUGG E 5 A_Stop;
      JUGG F 5 A_JuggernautDecide;
      Goto See;
    Charge:
		  JUGG J 2 A_JuggernautCharge;
		  Loop;
    ChargeRecover:
      JUGG E 14 A_Pain;
      Goto See;
    Pain:
      JUGG E 2;
      JUGG E 2 A_Pain;
      Goto See;
    Death:
      JUGG K 6 A_Scream;
      JUGG LM 6;
      JUGG N 6 A_StartSound ("Juggernaut/Thud");
      JUGG O 6 A_NoBlocking;
      JUGG P 6;
      JUGG Q -1;
      Stop;
  }

  void A_JuggernautDecide()
	{
      chargeAttempt = 0;

		  if (!target)
        return;
  
      A_StartSound ("Juggernaut/Sight", CHAN_WEAPON);
      // Charge attack
      // Don't call the state function right away
      SetStateLabel("Charge", true);
      bSkullFly = true;
      
      A_FaceTarget ();
      VelFromAngle(JUGG_CHARGE_SPEED);
      special1 = TICRATE/2; // Charge duration

      chargeAttempt = special1;
	}

  void A_JuggernautCharge()
	{
		if (target == null)
		{
			return;
		}
		if (special1 > 0)
		{
			Class<Actor> type;

			type = "PunchPuff";

			Actor puff = Spawn (type, Pos, ALLOW_REPLACE);
			if (puff != null) puff.Vel.Z = 2;
			special1--;
		}
		else
		{
			bSkullFly = false;

      if (chargeAttempt > 1)
        SetStateLabel("ChargeRecover", true);
      else
        SetState(SeeState);
		}
	}
}