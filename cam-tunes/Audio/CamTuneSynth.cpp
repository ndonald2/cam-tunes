

#include "Tonic.h"

using namespace Tonic;

class CamTuneSynth : public Synth
{
    
public:
    
    CamTuneSynth(){
        
        ControlMetro baseMetro = ControlMetro().bpm(120);
                
        // Kick drum
        ADSR kickEnv =
        ADSR(0.001,0.2,0.0,0.01)
        .legato(true)
        .doesSustain(false)
        .exponential(true)
        .trigger(baseMetro);
        
        ADSR kickPitchEnv =
        ADSR(0.001,0.1,0.0,0.01)
        .legato(true)
        .doesSustain(false)
        .exponential(true)
        .trigger(baseMetro);
        
        Generator kickGen = SineWave().freq(60 * (1.0f + kickPitchEnv * 2.f)) * kickEnv;
        
        setOutputGen(kickGen);
    }
    
};

registerSynth(CamTuneSynth);
