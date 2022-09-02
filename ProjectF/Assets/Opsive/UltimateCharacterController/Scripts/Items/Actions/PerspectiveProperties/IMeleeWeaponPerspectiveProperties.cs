/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Items.Actions.PerspectiveProperties
{
    using UnityEngine;

    /// <summary>
    /// Interface for an object which contains the perspective dependent variables for a MeleeWeapon.
    /// </summary>
    public interface IMeleeWeaponPerspectiveProperties
    {
        MeleeWeapon.MeleeHitbox[] Hitboxes { get; set; }
        Transform TrailLocation { get; set; } 
    }
}