package ar.edu.dds.utn.observers

class Mail {
	@Property String from
	@Property String to
	@Property String message
	@Property String titulo
	new(String mifrom,String mito,String mititulo,String mimessage){
		from=mifrom;
		to=mito;
		titulo=mititulo;
		message=mimessage;
	}
	new(){
		
	}
}