package com.volumetester

import android.content.Context
import android.media.AudioManager
import com.facebook.react.bridge.*


class VolumeManager(reactContext: ReactApplicationContext): ReactContextBaseJavaModule(reactContext) {
    private val audioManager = reactApplicationContext.getSystemService(Context.AUDIO_SERVICE) as AudioManager

    override fun getName(): String {
        return "VolumeManager"
    }

    @ReactMethod
    fun currentVolume(callback: Callback) {
        callback.invoke(getVolumePercent(audioManager.mediaCurrentVolume))
    }

    @ReactMethod
    fun incrementVolume(promise: Promise) {
        val newVolume = audioManager.mediaCurrentVolume + 1
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, AudioManager.FLAG_PLAY_SOUND)
        promise.resolve(getVolumePercent(newVolume))
    }

    @ReactMethod
    fun decrementVolume(promise: Promise) {
        val newVolume = audioManager.mediaCurrentVolume - 1
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, AudioManager.FLAG_PLAY_SOUND)
        promise.resolve(getVolumePercent(newVolume))
    }
















    private fun getVolumePercent(volume: Int): Float {
        if (volume > audioManager.mediaMaxVolume) {
            return 1f
        }
        if (volume < audioManager.mediaMinVolume) {
            return 0f
        }
        val percent = volume.toFloat() / audioManager.mediaMaxVolume.toFloat()
        return percent
    }
}


val AudioManager.mediaCurrentVolume: Int
    get() = this.getStreamVolume(AudioManager.STREAM_MUSIC)


val AudioManager.mediaMaxVolume: Int
    get() = this.getStreamMaxVolume(AudioManager.STREAM_MUSIC)

val AudioManager.mediaMinVolume: Int
    get() = this.getStreamMinVolume(AudioManager.STREAM_MUSIC)
