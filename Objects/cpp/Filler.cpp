
class Filler : public dEn_c {
public:

	int onCreate();
	int onExecute();
	int onDelete();
	int onDraw();

	
	

	static dActor_c* build();

		};


dActor_c* Filler::build() {
	void *buffer = AllocFromGameHeap1(sizeof(Filler));
	return new(buffer) Filler;
}

const SpriteData FillerSpriteData = 
{ ProfileId::Filler, 0, 0, 0, 0, 0x100, 0x100, 0, 0, 0, 0, 0 };

Profile FillerProfile(&Filler::build, SpriteId::Filler, &FillerSpriteData, ProfileId::Filler, ProfileId::Filler, "Filler" );


int Filler::onCreate() {


	this->onExecute();

	return true;
}

int Filler::onExecute() {
	return true;
}

int Filler::onDelete() {
	return true;
}

int Filler::onDraw() {
	return true;
}