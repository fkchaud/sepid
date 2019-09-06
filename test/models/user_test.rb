require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'verificar mail de usuario' do
    assert_equal 'pablobaldini1994@gmail.com', users(:one).email
  end

  test 'verificar longitud telefono' do
    assert_equal 10, users(:two).telephone.length
  end

  test 'verificar telefono' do
    assert_equal '2614056798', users(:two).telephone
  end

  # why?
  # test 'verificar nombre mayus' do
  #   assert_equal 'Luis', users(:three).first_name # en el fixture el nombre esta en minuscula
  # end

  test 'verificar nombre cargo universitario' do
    id_cargo_universitario = users(:two).university_position_id # busco la relacion de cargo universitario con usuario
    assert_equal 'profesor', university_positions(id_cargo_universitario).name # busco nombre de cargo universitario
  end

end