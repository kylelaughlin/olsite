require 'test_helper'

class GigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gig = gigs(:one)
  end

  test "should get index" do
    get gigs_url
    assert_response :success
  end

  test "should get new" do
    get new_gig_url
    assert_response :success
  end

  test "should create gig" do
    assert_difference('Gig.count') do
      post gigs_url, params: { gig: { location: @gig.location, performance_date: @gig.performance_date, time: @gig.time, venue: @gig.venue } }
    end

    assert_redirected_to gig_url(Gig.last)
  end

  test "should show gig" do
    get gig_url(@gig)
    assert_response :success
  end

  test "should get edit" do
    get edit_gig_url(@gig)
    assert_response :success
  end

  test "should update gig" do
    patch gig_url(@gig), params: { gig: { location: @gig.location, performance_date: @gig.performance_date, time: @gig.time, venue: @gig.venue } }
    assert_redirected_to gig_url(@gig)
  end

  test "should destroy gig" do
    assert_difference('Gig.count', -1) do
      delete gig_url(@gig)
    end

    assert_redirected_to gigs_url
  end
end
