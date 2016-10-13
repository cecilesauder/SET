context( "is_set" )

test_that("egal_", {
  expect_true(  egal_( c(1,1,1) ) )
  expect_true(  egal_( c(2,2,2) ) )
  expect_false( egal_( c(1,2,1) ) )
})

test_that("different_", {
  expect_true(  different_( c(1,2,3) ) )
  expect_true(  different_( c(3,1,2) ) )
  expect_false( different_( c(1,2,1) ) )
})

test_that("is_set_1col", {
  expect_true(  is_set_1col( c(1,1,1) ) )
  expect_true(  is_set_1col( c(2,2,2) ) )
  expect_true(  is_set_1col( c(1,2,3) ) )
  expect_true(  is_set_1col( c(3,1,2) ) )
  
  expect_false( is_set_1col( c(1,2,1) ) )
})