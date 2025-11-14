# frozen_string_literal: true

class SpreadsheetsController < ApplicationController
  load_and_authorize_resource

  # GET /spreadsheets
  # GET /spreadsheets.json
  def index
    @spreadsheets = Spreadsheet.all
  end

  # GET /spreadsheets/1
  # GET /spreadsheets/1.json
  def show; end

  # GET /spreadsheets/new
  def new
    @spreadsheet = Spreadsheet.new
  end

  # GET /spreadsheets/1/edit
  def edit; end

  # POST /spreadsheets/1/import
  def import
    if @spreadsheet.import
      redirect_to root_url, notice: 'Spreadsheet was successfully imported.'
    else
      render :show
    end
  end

  # POST /spreadsheets
  # POST /spreadsheets.json
  def create
    @spreadsheet = Spreadsheet.new(spreadsheet_params)

    respond_to do |format|
      if @spreadsheet.save
        format.html { redirect_to @spreadsheet, notice: 'Spreadsheet was successfully created.' }
        format.json { render :show, status: :created, location: @spreadsheet }
      else
        format.html { render :new }
        format.json { render json: @spreadsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spreadsheets/1
  # PATCH/PUT /spreadsheets/1.json
  def update
    respond_to do |format|
      if @spreadsheet.update(spreadsheet_params)
        format.html { redirect_to @spreadsheet, notice: 'Spreadsheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @spreadsheet }
      else
        format.html { render :edit }
        format.json { render json: @spreadsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spreadsheets/1
  # DELETE /spreadsheets/1.json
  def destroy
    @spreadsheet.destroy
    respond_to do |format|
      format.html { redirect_to spreadsheets_url, notice: 'Spreadsheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def spreadsheet_params
    params.expect(spreadsheet: [:attachment])
  end
end
