dclLoopAdd : dialog { 
	  label = "Dodaj nowa petle";
 
	  : column {
    		label = "Utworz petle";
        : row {
          :edit_box {
            label = "Panel:";
            value = "";
            mnemonic = "P";
            edit_limit = 10;
            edit_width = 20;
            alignment = left;
            is_enabled = false;
          }

          : list_box {				//define list box
            key = "lb1";				//give it a name
            list = "Centrala 1\nCentrala 2\nCentrala 3\nCentrala 4\nCentrala 5";	//the list
            tabs = "2 4";				//set tabs
            height = 5;				//give it a height
            width = 19;				//give it a width
            fixed_width = true;			//fix the width
            fixed_height = true;			//fix the height
            alignment = centered;			//center it
          }	

        }
        : row {
          : button {
            label = "AWEX"; 
            key = "zmienSystemAwex";	
            alignment = centered; 
            width = 12;
          }
  
          : button {
            label = "BOSCH"; 
            key = "zmienSystemBosch";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "ESSER"; 
            key = "zmienSystemEsser";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "EST3"; 
            key = "zmienSystemEST3";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "FP2000"; 
            key = "zmienSystemFP2000";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "POLON4200"; 
            key = "zmienSystemPolon4200";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "POLON4900"; 
            key = "zmienSystemPolon4900";	
            alignment = centered; 
            width = 12;
          }
        }
    }

	: row {
		label = "Nazwa parametru";

		:edit_box {
			key = "nazwaParametru";
			label = "Nazwa parametru";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 10;
		}
		: button {
			label = "Zmien"; 
			key = "zmienNazwe";	
			alignment = centered; 
			width = 12;
			is_default = true;
		}
	}
 
	: column {
 		: row {
 			: button {
				label = "U-L"; 
				key = "ul";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "U-C"; 
				key = "uc";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "U-R"; 
				key = "ur";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
		}
 
		: row {
 			: button {
				label = "M-L"; 
				key = "ml";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "M-C"; 
				key = "mc";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "M-R"; 
				key = "mr";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
		}
 
		: row {
 			: button {
				label = "D-L"; 
				key = "dl";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "D-C"; 
				key = "dc";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "D-R"; 
				key = "dr";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
		}
		
		:row{
 			: button {
				label = "Wybierz nastepny"; 
				key = "wn";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
 			: button {
				label = "Koniec"; 
				key = "ko";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
			}
		}
 
	}


}