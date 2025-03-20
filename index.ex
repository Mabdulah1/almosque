defmodule FirstprojectWeb.Index do
  use FirstprojectWeb, :live_view
  import Phoenix.HTML.Form  
  import Phoenix.Component

  def mount(_params, _session, socket) do
    form = %{
      "fajr" => "Omar Hisham Al-Arabi",
      "dhuhr" => "Abdul Basit Abdul Samad", 
      "asr" => "Mishary Rashid Alafasy",
      "maghrib" => "Abdul Basit Abdul Samad",
      "isha" => "Madina",
      "tahajjud" => "No Reminder (Muted)",
      "dua_after_adhan" => "No Reminder (Muted)",
      "volume" => 75
    }

    {:ok, assign(socket, 
      active_tab: "reminders",
      adhan_form: form,
      sync_with_mosque: "SYNC-WITH-MOSQUE",
      standalone_device: "STAND-ALONE-DEVICE"
    )}
  end

  def handle_event("switch_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end

  def handle_event("sync_with_mosque", _params, socket) do
    {:noreply, push_navigate(socket, to: "/SYNC-WITH-MOSQUE")}
  end 

  def handle_event("standalone_device", _params, socket) do
    {:noreply, assign(socket, active_tab: "Stand-Alone-Device")}
  end

  def settings_nav(assigns) do
    ~H"""
    <div class="flex flex-col md:flex-row items-center px-4 md:px-6 py-4 space-y-4 md:space-y-0">
      <div class="flex items-center w-full md:w-auto">
        <div class="flex-shrink-0">
          <button class="w-8 h-8 rounded-full font-extrabold bg-gradient-to-b from-[#C28D47] to-brown-500 flex justify-center items-center shadow-lg">
            <.icon name="hero-arrow-left" class="w-5 h-5 text-black font-extrabold" />
          </button>
        </div>
        <h1 class="text-xl md:text-2xl font-bold text-black ml-4">SETTINGS</h1>
      </div>
      <div class="flex flex-1 justify-center md:justify-end w-full md:w-auto">
        <div class="flex rounded-md bg-gray-200 border border-[#061131]">
          <%= for {tab, label} <- [{"mosque", "MOSQUE"}, {"reminders", "REMINDERS"}, {"general", "GENERAL"}] do %>
            <button 
              class={"#{if @active_tab == tab, do: "bg-[#16529A] text-white", else: "text-[#061131]"} px-4 py-2 #{if @active_tab == tab, do: "rounded-lg"} transition-all duration-200 font-semibold"}
              phx-click="switch_tab"
              phx-value-tab={tab}
            >
              <%= label %>
            </button>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def adhan_field(assigns) do
    ~H"""
    <div class={"flex flex-col ml-9 md:flex-row m-[-1px] items-start md:items-center justify-between bg-[#E4D0A8] #{if @name in ["fajr"], do: "rounded-t-xl"} #{if @name in ["tahajjud"], do: "rounded-b-xl"} #{if @name in ["dua_after_adhan"], do: "bg-transparent" }  h-14"}>
      <div class="flex ml-[1em] mt-2 md:mt-0">
        <.label class="w-24 text-sm sm:text-base"><%= @label %></.label>
      </div>
      <div class="flex items-center w-full sm:w-40 md:w-48 lg:w-56 xl:w-64 h-8 mt-1 md:mt-0 mr-2">
        <div class="relative w-full rounded-xl">
          <div class="absolute inset-y-0 left-0 flex items-center pointer-events-none">
            <span class="text-xs sm:text-sm md:text-base truncate px-3 pr-8"><%= @value %></span>
          </div>
          <select 
            name={@name} 
            class="w-full h-8 rounded-xl border border-gray-300 focus:border-blue-500 focus:ring-blue-500 appearance-none cursor-pointer text-transparent"
          >
            <%= for option <- @options do %>
              <option value={option} selected={option == @value}><%= option %></option>
            <% end %>
          </select>
        </div>
      </div>
    </div>
    """
  end

  def render(assigns) do
    adhan_options = ["Omar Hisham Al-Arabi", "Abdul Basit Abdul Samad", "Mishary Rashid Alafasy"]
    assigns = assign(assigns, :adhan_options, adhan_options)

    ~H"""
    <div class="min-h-screen w-screen h-screen max-w-none bg-white">
      <.settings_nav active_tab={@active_tab} />

      <div class="p-4 md:p-6 h-[calc(100vh-5rem)] overflow-y-auto">
        <div :if={@active_tab == "mosque"} class="space-y-8 md:space-y-10 h-[30vh] flex flex-col justify-center">
          <span class="sm:text-md md:text-lg font-serif font-bold text-gray-800 mb-4 sm:pl-11 whitespace-nowrap">Do you want to sync with your local mosque or use it as a stand alone device?</span>
          <div class="flex justify-center items-center gap-8 mt-[14vh] mb-20">
            <button 
              phx-click="sync_with_mosque"
              class={"w-[200px] h-[40px] border-[1px] border-[#061131] rounded-lg transition-colors #{if @sync_with_mosque == "SYNC-WITH-MOSQUE", do: "hooho", else: ""}"}
            >
              <span class="font-serif text-md whitespace-nowrap">Sync with Mosque</span>
            </button>
            <button 
              phx-click="standalone_device"
              class={"w-[200px] h-[42px] border bg-[#061131] rounded-lg transition-colors #{if @standalone_device == "STAND-ALONE-DEVICE", do: "haha", else: ""}"}
            >
              <span class="font-serif text-md text-white whitespace-nowrap">Stand-Alone Device</span>
            </button>
          </div>
        </div>
        
        <div :if={@active_tab == "reminders"} class="h-full">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8 h-full">
            <div class="order-2 md:order-1">
              <h2 class="font-semibold text-lg text-center text-[#1C78B7] pb-1">ADHAN</h2>
              <.form for={%{}} as={:adhan} phx-submit="save" class="">
                <div class="pl-3 md:pl-1 lg:pl-1">
                  <div>
                    <%= for {label, name} <- [{"Fajr", "fajr"}, {"Dhuhr", "dhuhr"}, {"Asr", "asr"}, {"Maghrib", "maghrib"}, {"Isha", "isha"}, {"Tahajjud", "tahajjud"}] do %>  
                      <div class="flex items-center gap-2">
                        <div class="flex-grow">
                          <.adhan_field label={label} name={name} value={@adhan_form[name]} options={@adhan_options} />
                        </div>
                        <button 
                          class="flex items-center justify-center h-7 w-7 bg-[#1C78B7] rounded-full shadow-md hover:bg-[#1565a8] active:bg-[#125391] transition-colors"
                          phx-click="play_adhan"
                          phx-value-name={name}
                        >
                          <.icon name="hero-play-solid" class="w-4 h-4 text-white" />
                        </button>
                      </div>
                    <% end %>
                  </div>
                </div>

                <div class="mt-4">
                  <div class="pl-1">
                    <div class="flex items-center">
                      <div class="flex-grow">
                        <.adhan_field label="Dua After Adhan" name="dua_after_adhan" value={@adhan_form["dua_after_adhan"]} options={["No Reminder (Muted)"]} />
                      </div>
                      <button 
                        class="flex items-center justify-center h-7 w-7 bg-[#1C78B7] rounded-full shadow-md hover:bg-[#1565a8] active:bg-[#125391] transition-colors ml-2"
                        phx-click="play_adhan"
                        phx-value-name="dua_after_adhan"
                      >
                        <.icon name="hero-play-solid" class="w-4 h-4 text-white" />
                      </button>
                    </div>
                  </div>
                </div>

                <div class="flex items-center">
                  <span class="pr-[15vw] pt-[10px] font-semibold ml-12">Volume</span>
                  <div class="flex-grow pr-3 w-1/3">
                    <.input type="range" class="w-[100px]" min="0" max="100" value={@adhan_form["volume"]} name="volume" />
                  </div>
                  <button 
                    class="flex items-center justify-center h-7 w-7 bg-[#1C78B7] rounded-full shadow-md hover:bg-[#1565a8] active:bg-[#125391] transition-colors"
                    phx-click="play_adhan"
                    phx-value-name="volume_test"
                  >
                    <.icon name="hero-play-solid" class="w-4 h-4 text-white" />
                  </button>
                </div>
              </.form>
            </div>
            <div class="space-y-2 md:space-y-4 order-1 md:order-2">
              <h2 class="font-semibold text-lg text-[#1C78B7]">Reminder before IQAMA in Minutes</h2>
              <div class="rounded-lg space-y-4">
                <div class="flex flex-col space-y-4">
                  <%= for reminder <- ["Senan Hadif", "Beep 1", "Beep 2", "No Reminder (Muted)"] do %>
                    <div class="flex items-center justify-between">
                      <div class="flex flex-grow justify-between gap-3">
                        <select class="px-3 flex-grow bg-white border border-gray-300 rounded-2xl w-24 text-sm">
                          <option><%= reminder %></option>
                        </select>
                        <input type="number" class="px-3 py-1.5 bg-white border border-gray-300 rounded-xl w-12 text-sm text-center" value="0" />
                      </div>
                    </div>
      
      
                  <% end %>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div :if={@active_tab == "general"} class="space-y-4 md:space-y-6">
          <div class="flex gap-8">
            <div class="w-1/2 space-y-6">
              <%= if true do %>
                <div class="flex items-center justify-between">
                  <span>24-hr Time Format</span>
                  <div class="relative inline-block w-12 h-6 rounded-full bg-gray-200">
                    <input type="checkbox" class="sr-only peer" />
                    <span class="absolute inset-0 peer-checked:bg-[#1C78B7] rounded-full transition-colors"></span>
                    <span class="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform peer-checked:translate-x-6"></span>
                  </div>
                </div>

                <div class="flex items-center justify-between">
                  <span>Display Weather</span>
                  <div class="relative inline-block w-12 h-6 rounded-full bg-gray-200">
                    <input type="checkbox" class="sr-only peer" />
                    <span class="absolute inset-0 peer-checked:bg-[#1C78B7] rounded-full transition-colors"></span>
                    <span class="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform peer-checked:translate-x-6"></span>
                  </div>
                </div>

                <div class="flex items-center justify-between">
                  <span>Enable Live Streaming</span>
                  <div class="relative inline-block w-12 h-6 rounded-full bg-gray-200">
                    <input type="checkbox" class="sr-only peer" />
                    <span class="absolute inset-0 peer-checked:bg-[#1C78B7] rounded-full transition-colors"></span>
                    <span class="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform peer-checked:translate-x-6"></span>
                  </div>
                </div>

                <div class="flex items-center justify-between">
                  <span>Night Mode</span>
                  <div class="relative inline-block w-12 h-6 rounded-full bg-gray-200">
                    <input type="checkbox" class="sr-only peer" />
                    <span class="absolute inset-0 peer-checked:bg-[#1C78B7] rounded-full transition-colors"></span>
                    <span class="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform peer-checked:translate-x-6"></span>
                  </div>
                </div>

                <div class="flex ">
          <svg xmlns="http://www.w3.org/2000/svg" width="120px" height="120px" viewBox="3  3 18 18"><path d="M3 9h6V3H3zm1-5h4v4H4zm1 1h2v2H5zm10 4h6V3h-6zm1-5h4v4h-4zm1 1h2v2h-2zM3 21h6v-6H3zm1-5h4v4H4zm1 1h2v2H5zm15 2h1v2h-2v-3h1zm0-3h1v1h-1zm0-1v1h-1v-1zm-10 2h1v4h-1v-4zm-4-7v2H4v-1H3v-1h3zm4-3h1v1h-1zm3-3v2h-1V3h2v1zm-3 0h1v1h-1zm10 8h1v2h-2v-1h1zm-1-2v1h-2v2h-2v-1h1v-2h3zm-7 4h-1v-1h-1v-1h2v2zm6 2h1v1h-1zm2-5v1h-1v-1zm-9 3v1h-1v-1zm6 5h1v2h-2v-2zm-3 0h1v1h-1v1h-2v-1h1v-1zm0-1v-1h2v1zm0-5h1v3h-1v1h-1v1h-1v-2h-1v-1h3v-1h-1v-1zm-9 0v1H4v-1zm12 4h-1v-1h1zm1-2h-2v-1h2zM8 10h1v1H8v1h1v2H8v-1H7v1H6v-2h1v-2zm3 0V8h3v3h-2v-1h1V9h-1v1zm0-4h1v1h-1zm-1 4h1v1h-1zm3-3V6h1v1z"/><path fill="none" d="M0 0h24v24H0z"/></svg>
                  <p class="text-sm w-48 pl-4">Please scan this QR code to sync your device with our Almosque phone application.</p>
                </div>
              <% end %>
            </div>

            <div class="w-1/2">
              <div class="bg-[#E4D0A8] pl-6 pt-6 pb-1 rounded-lg">
                <div class="font-['Karma'] text-2xl font-bold text-center mb-4">
                  SUPPORT SETTINGS
                </div>
                
                <div class="text-center mb-6">
                  These settings should only be used when instructed by Almosque support.
                </div>

                <div class="mb-4">
                  <div class="font-bold inline-block border-b border-[#061131] ">DEVICE INFO</div>
                  <div class="space-y-1 mt-2">
                    <div>ID: 24356adi031m45-9</div>
                    <div>Version: 21.4</div>
                    <div>Last Updated: 21 April 2024 08:24 PM</div>
                    <div class="flex gap-16 justify-start pt-2">
                      <div class="h-8 w-24 bg-white  rounded-xl flex items-center justify-center text-xs border border-[#061131]">Update App</div>
                      <div class="h-8 w-24 bg-white  rounded-xl flex items-center justify-center text-xs border border-[#061131]">Restart Device</div>
                      <div class="h-8 w-24 bg-white rounded-xl flex items-center justify-center text-xs border border-[#061131]">Device Setting</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="flex justify-between items-center mt-8 px-6">
            <p class="font-['Karma'] text-xl font-semibold leading-none">
              Have a question? Send us an email at info@almosque.app and we would be happy to help you.
            </p>
            <div class="flex gap-2">
              <button class="w-[150px] h-[40px] bg-white text-[rgba(6,17,49,1)] border border-[#061131] rounded-lg">
                Change Theme
              </button>
              <button class="w-[150px] h-[40px] bg-[rgba(6,17,49,1)] text-white border border-[#061131] rounded-lg">
                Watch Tutorial
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end