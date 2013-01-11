<!--

    ( function($) {

        $(document).ready(function(){

          $('#login').addClass('textFld');
          $('#password').addClass('textFld');
          if ($('.errorExplanation').html() == 'Login or Password is incorrect.'){
            $('#nav').css('margin-bottom','0px');
          }else{
            $('#nav').css('margin-bottom','14px');
          }
          $('#home_image').click(function(){
            window.location.href = "/";
          });

          $('#cantact_us_form').submit(function(){
            if ($('#contact_user_name').val() == ''){
              $('#contact_user_name').css('border','red 2px solid');
            }else{
              $('#contact_user_name').css('border','');
            }
            if ($('#contact_user_email').val() == ''){
              $('#contact_user_email').css('border','red 2px solid');
            }else{
              $('#contact_user_email').css('border','');
            }
            if ($('#contact_user_message').val() == ''){
              $('#contact_user_message').css('border','red 2px solid');
            }else{
              $('#contact_user_message').css('border','');
            }
            if ($('#contact_user_message').val() == '' || $('#contact_user_email').val() == '' || $('#contact_user_name').val() == ''){
              return false;
            }else{
              return true;
            }
          });

        });

    } ) ( jQuery );

//-->
