package com.volumetester

import android.content.Context
import android.media.AudioManager
import com.facebook.react.bridge.*


class VolumeModule(reactContext: ReactApplicationContext): ReactContextBaseJavaModule(reactContext) {
    private val audioManager = reactApplicationContext.getSystemService(Context.AUDIO_SERVICE) as AudioManager

    override fun getName(): String {
        return "VolumeModule"
    }

    @ReactMethod
    fun mute() {
        audioManager.setMediaVolume(0)
    }

    @ReactMethod
    fun currentVolume(callback: Callback) {
        callback.invoke(getVolumePercent(audioManager.mediaCurrentVolume))
    }

    @ReactMethod
    fun incrementVolume(promise: Promise) {
        val newVolume = audioManager.mediaCurrentVolume + 1
        audioManager.setMediaVolume(newVolume)
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

fun AudioManager.setMediaVolume(volume: Int) {
    this.setStreamVolume(AudioManager.STREAM_MUSIC, volume, AudioManager.FLAG_PLAY_SOUND)

}

val AudioManager.mediaCurrentVolume: Int
    get() = this.getStreamVolume(AudioManager.STREAM_MUSIC)


val AudioManager.mediaMaxVolume: Int
    get() = this.getStreamMaxVolume(AudioManager.STREAM_MUSIC)

val AudioManager.mediaMinVolume: Int
    get() = this.getStreamMinVolume(AudioManager.STREAM_MUSIC)
