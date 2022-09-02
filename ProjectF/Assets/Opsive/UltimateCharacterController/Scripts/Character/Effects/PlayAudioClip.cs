/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Character.Effects
{
    using Opsive.Shared.Audio;
    using Opsive.Shared.Game;
    using UnityEngine;

    /// <summary>
    /// Plays an AudioClip when the effect starts.
    /// </summary>
    public class PlayAudioClip : Effect
    {
        [Tooltip("The AudioConfig that will play. If it is null then the AudioClipSet will be used.")]
        [SerializeField] protected AudioConfig m_AudioConfig;
        [Tooltip("A set of AudioClips that can be played when the effect is started.")]
        [HideInInspector] [SerializeField] protected AudioClipSet m_AudioClipSet = new AudioClipSet();

        public AudioConfig AudioConfig { get { return m_AudioConfig; } set { m_AudioConfig = value; } }
        public AudioClipSet AudioClipSet { get { return m_AudioClipSet; } set { m_AudioClipSet = value; } }

        /// <summary>
        /// Can the effect be started?
        /// </summary>
        /// <returns>True if the effect can be started.</returns>
        public override bool CanStartEffect()
        {
            if (m_AudioConfig != null && m_AudioConfig.AudioClips != null) {
                return m_AudioConfig.AudioClips.Length > 0;
            }
            return m_AudioClipSet.AudioClips.Length > 0;
        }

        /// <summary>
        /// The effect has been started.
        /// </summary>
        protected override void EffectStarted()
        {
            base.EffectStarted();

            AudioSource audioSource;
            if (m_AudioConfig != null && m_AudioConfig.AudioClips != null) {
                audioSource = m_AudioConfig.Play(m_GameObject).AudioSource;
            } else {
                audioSource = m_AudioClipSet.PlayAudioClip(m_GameObject).AudioSource;
            }
            if (audioSource != null) {
                SchedulerBase.ScheduleFixed(audioSource.clip.length, StopEffect);
            }
        }
    }
}