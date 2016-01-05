<?php

// lambda filter expression
return function($data){

  // BIT_MASK Macro expression
  // ---------------------------------------------------------------------------
  // BIT_MASK(PB1, PB4, PB5) will be expanded to "(1<<PB1 || 1<<PB4 || 1<<PB5)"
  $data = preg_replace_callback('/BIT_MASK\((.*)\)/U', function($match){
      // split expressions by comma
      $exp = explode(',', $match[1]);

      // prepend bitshift 1<<E
      $exp = array_map(function($e){
          return '1<<' . trim($e);
      }, $exp);

      // join the bit expressions
      return '(' . implode(' | ', $exp) . ')';
  }, $data);



  return $data;
};
