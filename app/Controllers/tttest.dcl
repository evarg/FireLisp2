listbox : dialog {
  label="List Box Example";
  spacer;
  : row { : list_box {
      key="lst";
      width=35;
      height=15;
      fixed_width=true;
      fixed_height=true;
      multiple_select=true;
      }
    : column {
      fixed_height=true;
      : button {
        key="top";
        label="Top";
        }
      : button { key="up"; label="Up" ; }
      : button { key="down"; label="Down"; }
      : button { key="bottom"; label="Bottom"; }}
    } spacer; ok_only;
  }


