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

    {:ok,
     assign(socket,
       active_tab: "reminders",
       adhan_form: form,
       sync_with_mosque: nil,
       standalone_device: nil,
       mosque_view: nil,
       show_clear: false,
       search_text: "",
       calculation_method: "Custom",
       asr_method: "Standard",
       higher_latitude: "No Adjustment",
       hijri_offset: 0,
       timezone: "America/New_York",
       fajr_angle: "18.5 degrees°",
       isha_angle: "18.0 degrees°",
       initial_state: %{
         calculation_method: "Custom",
         asr_method: "Standard",
         higher_latitude: "No Adjustment",
         hijri_offset: 0,
         timezone: "America/New_York",
         fajr_angle: "18.5 degrees°",
         isha_angle: "18.0 degrees°"
       }
     )}
  end

  def handle_event("switch_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end

  def handle_event("sync_with_mosque", _params, socket) do
    {:noreply,
     assign(socket,
       sync_with_mosque: "SYNC-WITH-MOSQUE",
       standalone_device: nil,
       mosque_view: "sync"
     )}
  end

  def handle_event("standalone_device", _params, socket) do
    {:noreply,
     assign(socket,
       standalone_device: "STAND-ALONE-DEVICE",
       sync_with_mosque: nil,
       mosque_view: "standalone",
       show_clear: false,
       search_text: ""
     )}
  end

  def handle_event("go_back", _params, socket) do
    {:noreply,
     assign(socket,
       sync_with_mosque: nil,
       standalone_device: nil,
       mosque_view: nil
     )}
  end

  def handle_event("show_clear", _params, socket) do
    {:noreply, assign(socket, show_clear: true)}
  end

  def handle_event("hide_clear", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("clear_search", _params, socket) do
    {:noreply, assign(socket, search_text: "", show_clear: false)}
  end

  def handle_event("search", %{"value" => search_text}, socket) do
    {:noreply, assign(socket, search_text: search_text)}
  end

  def handle_event("reset_standalone", _params, socket) do
    {:noreply,
     assign(socket,
       calculation_method: socket.assigns.initial_state.calculation_method,
       asr_method: socket.assigns.initial_state.asr_method,
       higher_latitude: socket.assigns.initial_state.higher_latitude,
       hijri_offset: socket.assigns.initial_state.hijri_offset,
       timezone: socket.assigns.initial_state.timezone,
       fajr_angle: socket.assigns.initial_state.fajr_angle,
       isha_angle: socket.assigns.initial_state.isha_angle
     )}
  end

  def settings_nav(assigns) do
    ~H"""
    <div class="flex flex-col md:flex-row items-center px-6 md:px-8 pt-8 space-y-4 md:space-y-0">
      <div class="flex items-center w-full md:w-auto">
        <div class="flex-shrink-0">
          <button
            phx-click="go_back"
            class="w-12 h-12 rounded-full font-extrabold bg-gradient-to-b from-[#C28D47] to-brown-500 flex justify-center items-center shadow-lg"
          >
            <.icon name="hero-arrow-left" class="w-8 h-8 text-black font-extrabold" />
          </button>
        </div>
        <h1 class="text-3xl md:text-4xl font-bold text-black ml-6">
          <%= if @active_tab == "mosque" && @mosque_view == "sync" do %>
            SYNC MOSQUE
          <% else %>
            SETTINGS
          <% end %>
        </h1>
      </div>
      <div class="flex flex-1 justify-center  md:justify-end  pr-10">
        <div class="flex rounded-2xl  bg-gray-200 border-2 border-[#061131] ">
          <%= for {tab, label} <- [{"mosque", "MOSQUE"}, {"reminders", "REMINDERS"}, {"general", "GENERAL"}] do %>
            <button
              class={"#{if @active_tab == tab, do: "bg-[#16529A] w-[16vw]  text-white rounded-xl", else: "text-[#061131]  w-[20vw]  py-3 rounded-xl"}  text-xl #{if @active_tab == tab, do: "rounded-lg"} transition-all duration-200 font-semibold"}
              phx-click="switch_tab"
              phx-value-tab={tab}
            >
              {label}
            </button>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def adhan_field(assigns) do
    ~H"""
    <div class={"flex flex-col ml-[3.5em] md:flex-row m-[-1px]  items-start md:items-center justify-between bg-[#E4D0A8] #{if @name in ["fajr"], do: "rounded-t-xl"} #{if @name in ["tahajjud"], do: "rounded-b-xl"} #{if @name in ["dua_after_adhan"], do: "bg-transparent" }  h-14"}>
      <div class="flex ml-[1em] mt-2 font-serif md:mt-0">
        <.label class="w-24  sm:text-base ">{@label}</.label>
      </div>
      <div class="flex items-center w-full sm:w-40 md:w-48 lg:w-56 xl:w-64 h-8 mt-1 md:mt-0 mr-2">
        <div class="relative w-full rounded-xl">
          <div class="absolute inset-y-0 left-0 flex items-center pointer-events-none">
            <span class="text-xs sm:text-sm  font-serif md:text-base truncate px-3 pr-8">
              {@value}
            </span>
          </div>
          <select
            name={@name}
            class="w-full h-8 rounded-xl border border-[#061131] focus:border-blue-500 focus:ring-blue-500 appearance-none cursor-pointer text-transparent"
          >
            <%= for option <- @options do %>
              <option value={option} selected={option == @value}>{option}</option>
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
      <.settings_nav active_tab={@active_tab} mosque_view={@mosque_view} />

      <div class="p-6 md:p-8 h-[calc(100vh-6rem)] overflow-y-auto">
        <div :if={@active_tab == "mosque"} class=" flex flex-col justify-center">
          <%= if is_nil(@mosque_view) do %>
            <span class="sm:text-xl md:text-2xl font-serif font-bold pt-[10vh] text-gray-800  sm:pl-[5vw] whitespace-nowrap">
              Do you want to sync with your local mosque or use it as a stand alone device?
            </span>
            <div class="flex justify-center items-center gap-10 mt-[16vh] mb-24">
              <button
                phx-click="sync_with_mosque"
                class={"w-[350px] h-[60px] border-2 border-[#061131] rounded-xl transition-colors #{if @sync_with_mosque == "SYNC-WITH-MOSQUE", do: "bg-[#061131] text-white", else: ""} text-lg"}
              >
                <span class="font-serif  text-2xl whitespace-nowrap">Sync with Mosque</span>
              </button>
              <button
                phx-click="standalone_device"
                class={"w-[350px] h-[60px] border-2 bg-[#061131] rounded-xl transition-colors #{if @standalone_device == "STAND-ALONE-DEVICE", do: "bg-white text-[#061131]", else: "text-white"} text-lg"}
              >
                <span class="font-serif  text-2xl whitespace-nowrap">Stand-Alone Device</span>
              </button>
            </div>
          <% end %>

          <%= if @mosque_view == "sync" do %>
            <div class="text-center pl-[5vw]">
              <!-- left side content -->
              <div class="pt-5 ">
                <div class="flex ">
                  <div class="relative">
                    <input
                      type="text"
                      placeholder="Enter mosque name..."
                      class="h-12 w-[34vw] pl-3 pr-10 font-serif text-xl  border-2 border-[#061131] rounded-2xl "
                    />
                    <div class="absolute inset-y-0 right-3 flex items-center">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5 text-gray-500"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="5"
                          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                        />
                      </svg>
                    </div>
                  </div>
                  <div>
                    <!-- Right side content -->
                    <div class="text-left font-serif pt-3 pl-14 text-xl">
                      Your mosque:<span class="text-[#16529A] font-serif">  Malden Islamic Centre</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="text-left font-serif pt-10 pr-9 font-[arial] text-lg">
                Only mosques registered with Almosque.app will be displayed here. If you can't find your mosque here, please have your mosque administrator contact us at info@almosque.app for free registration.
              </div>
              <div class="text-left  pt-10  font-bold text-lg">
                Nearby Mosques:
              </div>
              <div class="pt-3">
                <div class="h-[8vh]  w-[27vw] border border-[#061131] bg-[#E4D0A8] rounded-xl">
                  <div class="pt-1 text-left g-[#797171] pl-4  text-lg font-serif">
                    <span class="text-lg font-serif text-white no-gap block ">
                      Malden Islamic Centre
                    </span>
                    <span class="text-sm font-serif text-white no-gap block ">405 pearl street</span>
                  </div>
                </div>
              </div>

              <div class="pt-3">
                <div class="h-[8vh]  w-[27vw] bg-[#797171] rounded-xl">
                  <div class="pt-1 text-left g-[#797171] pl-4  text-lg font-serif">
                    <span class="text-lg font-serif text-white no-gap block ">
                      Islamic Cultural Centre of Medford
                    </span>
                    <span class="text-sm font-serif text-white no-gap block ">43 High street</span>
                  </div>
                </div>
              </div>

              <div class="pt-3">
                <div class="h-[8vh]  w-[27vw] bg-[#797171] rounded-xl">
                  <div class="pt-1 text-left g-[#797171] pl-4  text-lg font-serif">
                    <span class="text-lg font-serif text-white no-gap block ">
                      Masjid Ahlus-Sunnah wal-Jama'ah
                    </span>
                    <span class="text-sm font-serif text-white no-gap block ">41 Marble street</span>
                  </div>
                </div>
              </div>

              <div class="pt-3">
                <div class="h-[8vh]  w-[27vw] bg-[#797171] rounded-xl">
                  <div class="pt-1 text-left g-[#797171] pl-4  text-lg font-serif">
                    <span class="text-lg font-serif text-white no-gap block ">
                      New England Islamic Centre
                    </span>
                    <span class="text-sm font-serif text-white no-gap block ">23 School street</span>
                  </div>
                </div>
              </div>
            </div>
          <% end %>

          <%= if @mosque_view == "standalone" do %>
            <div class="pt-[3vh] pl-[5.5vw] pr-[3.5vw]">
              <div class="relative w-full">
                <input
                  type="text"
                  placeholder="Your location"
                  phx-focus="show_clear"
                  value={@search_text}
                  phx-keyup={JS.push("search", value: %{value: ""})}
                  class="h-[5vh] w-full pl-3 pb-2 border border-[#061131] rounded-xl text-lg font-serif"
                />
                <div class="absolute right-4 top-1/2 -translate-y-1/2">
                  <%= if @show_clear do %>
                    <button phx-click="clear_search" class="mt-2">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5 text-gray-500"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="5"
                          d="M6 18L18 6M6 6l12 12"
                        />
                      </svg>
                    </button>
                  <% else %>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-5 w-5 text-gray-500"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="5"
                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                      />
                    </svg>
                  <% end %>
                </div>
              </div>
            </div>
            <div class="pt-14 pl-[5.5vw] pr-[3.5vw]">
              <div class="flex justify-between items-start gap-6">
                <div class="flex flex-col space-y-6 flex-grow">
                  <div class="flex items-center">
                    <span class="w-[180px] font-serif">Calculation Method</span>

                    <select class="h-[5vh] w-[50%] pl-3 border-2 border-[#061131] rounded-xl text-lg font-serif mx-auto leading-[2vh] appearance-none">
                      <option>Muslim World League</option>
                      <option>Islamic Society of North America</option>
                    </select>
                  </div>

                  <div class="flex items-center">
                    <span class="w-[180px] font-serif">Asr Method</span>
                    <select class="h-[5vh] w-[50%] pl-3 border-2 border-[#061131] rounded-xl text-lg font-serif mx-auto leading-[2vh] appearance-none">
                      <option>Standard (Shafi'i)</option>
                      <option>Hanafi</option>
                    </select>
                  </div>

                  <div class="flex items-center">
                    <span class="w-[180px] font-serif">Higher Latitude Method</span>
                    <select class="h-[5vh] w-[50%] pl-3 border-2 border-[#061131] rounded-xl text-lg font-serif mx-auto leading-[2vh] appearance-none">
                      <option>Middle of the Night</option>
                      <option>One-Seventh</option>
                    </select>
                  </div>

                  <div class="flex items-center">
                    <span class="w-[180px] font-serif">Hijri Offset</span>
                    <select class="h-[5vh] w-[50%] pl-3 border-2 border-[#061131] rounded-xl text-lg font-serif mx-auto leading-[2vh] appearance-none">
                      <option>0</option>
                      <option>1</option>
                    </select>
                  </div>

                  <div class="flex items-center">
                    <span class="w-[180px] font-serif">Timezone</span>
                    <select class="h-[5vh] w-[50%] pl-3 border-2 border-[#061131] rounded-xl text-lg font-serif mx-auto leading-[2vh] appearance-none">
                      <option>GMT-5 (EST)</option>
                      <option>GMT-4 (EDT)</option>
                    </select>
                  </div>
                </div>

                <div class="w-[17vw] h-[24vh] bg-[#E4D0A8] rounded-lg">
                  <div class="text-sm font-serif mb-5 p-4">
                    Set custom angles to calculate Fajr and Isha times
                  </div>
                  <div class="flex items-center px-4">
                    <span class="font-serif text-sm w-[12vw] whitespace-nowrap pr-2">Fajr Angle</span>
                    <div class="relative w-[10vw]">
                      <select class="h-[4vh] w-[10vw] pl-3 border-2 border-[#061131] rounded-lg text-sm font-serif leading-[2vh] appearance-none">
                        <option>18.0°</option>
                        <option>15.0°</option>
                      </select>
                    </div>
                  </div>

                  <div class="flex items-center pt-5 px-4">
                    <span class="font-serif text-sm w-[12vw] whitespace-nowrap pr-2">Isha Angle</span>
                    <div class="relative w-[10vw]">
                      <select class="h-[4vh] w-[10vw] pl-3 border-2 border-[#061131] rounded-lg text-sm font-serif leading-[1vh] appearance-none">
                        <option>18.5°</option>
                        <option>15.5°</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="flex justify-end gap-3 pt-[10vh] mb-[100%] pr-10">
              <button
                type="reset"
                phx-click="reset_standalone"
                class="px-4 w-[8vw] h-[7vh] text-2xl py-2 bg-gray-200 text-gray-700 rounded-xl bg-white border border-[#061131] font-serif"
              >
                Reset
              </button>
              <button
                type="submit"
                class="px-4 py-2 bg-[#061131] text-white rounded-xl hover:bg-[#1565a8] w-[8vw] text-2xl font-serif"
              >
                Save
              </button>
            </div>
          <% end %>
        </div>

        <div :if={@active_tab == "reminders"} class="h-full">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-[50px] h-full">
            <div class="order-2 md:order-1">
              <h2 class="font-serif text-lg text-center text-[#16529A] pb-1">ADHAN</h2>
              <.form for={%{}} as={:adhan} phx-submit="save" class="">
                <div class="pl-3 md:pl-1 lg:pl-1 ">
                  <div>
                    <%= for {label, name} <- [{"Fajr", "fajr"}, {"Dhuhr", "dhuhr"}, {"Asr", "asr"}, {"Maghrib", "maghrib"}, {"Isha", "isha"}, {"Tahajjud", "tahajjud"}] do %>
                      <div class="flex items-center gap-2">
                        <div class="flex-grow">
                          <.adhan_field
                            label={label}
                            name={name}
                            value={@adhan_form[name]}
                            options={@adhan_options}
                          />
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
                  <div class="">
                    <div class="flex items-center">
                      <div class="flex-grow">
                        <.adhan_field
                          label="Dua After Adhan"
                          name="dua_after_adhan"
                          value={@adhan_form["dua_after_adhan"]}
                          options={["No Reminder (Muted)"]}
                        />
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

                <div class="flex items-center font-karma ">
                  <span class="pr-[14.5vw] pt-[1.5vh]  text-lg font-karma font-bold  ml-[5.5vw]">Volume</span>
                  <div class="flex-grow pr-3 w-1/3">
                    <.input
                      type="range"
                      class="w-[100px]"
                      min="0"
                      max="100"
                      value={@adhan_form["volume"]}
                      name="volume"
                    />
                  </div>
                  <button>
                    <svg
                      width="30"
                      height="30"
                      viewBox="0 0 42 39"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M24.1335 10.9919C24.042 10.1298 23.9466 9.23525 23.7122 8.34265C23.0735 6.20726 21.3042 4.87502 19.4071 4.87502C18.3491 4.87121 17.0106 5.50687 16.2518 6.15016L9.96214 11.2869H6.66954C4.24634 11.2869 2.29785 13.1083 1.92989 15.7366C1.61722 18.2602 1.54096 23.024 1.92989 25.8006C2.26734 28.5774 4.12813 30.3721 6.66954 30.3721H9.96214L16.3739 35.585C17.0316 36.1427 18.1927 36.7821 19.2604 36.7821C19.3289 36.7841 19.39 36.7841 19.4509 36.7841C21.3842 36.7841 23.0867 35.4024 23.7255 33.2727C23.966 32.3723 24.0504 31.5283 24.132 30.7129L24.1335 30.6976L24.2193 29.885C24.5471 27.2491 24.5471 14.3929 24.2193 11.776L24.1335 10.9919ZM31.4962 11.0699C30.9718 10.3163 29.9327 10.1279 29.172 10.6512C28.4189 11.1784 28.2322 12.2176 28.7564 12.9693C30.2149 15.0647 31.0177 17.8549 31.0177 20.8295C31.0177 23.8024 30.2149 26.5943 28.7564 28.6898C28.2322 29.4415 28.4189 30.4806 29.174 31.0078C29.4562 31.202 29.786 31.3048 30.1253 31.3048C30.6726 31.3048 31.1835 31.0364 31.4962 30.5891C33.3378 27.9437 34.354 24.478 34.354 20.8295C34.354 17.1811 33.3378 13.7154 31.4962 11.0699ZM34.9207 5.26688C35.6795 4.7416 36.7224 4.93382 37.2429 5.6856C40.0951 9.77937 41.666 15.1597 41.666 20.8294C41.666 26.5028 40.0951 31.8813 37.2429 35.975C36.932 36.4223 36.4193 36.6907 35.872 36.6907C35.5327 36.6907 35.2047 36.5879 34.9226 36.3937C34.1677 35.8665 33.9807 34.8293 34.5031 34.0757C36.9702 30.5319 38.3297 25.8272 38.3297 20.8294C38.3297 15.8335 36.9702 11.1287 34.5031 7.58499C33.9807 6.83323 34.1677 5.79407 34.9207 5.26688Z"
                        fill="#16529A"
                      />
                    </svg>
                  </button>
                </div>
              </.form>
            </div>
            <div class="space-y-1 md:space-y-2 order-1 sm:order-2">
              <h2 class="font-serif pl-4 text-lg text-[#1C78B7]">Reminder before IQAMA in Minutes</h2>
              <div class="rounded-lg space-y-4">
                <div class="flex flex-col space-y-4">
                  <div class="flex items-center justify-between">
                    <div class="flex  justify-between gap-3">
                      <select class="px-4  flex-grow bg-white border font-serif  border-[#061131] rounded-2xl w-[36vw] text-sm">
                        <option>Senan Hadif</option>
                      </select>
                      <input
                        type="number"
                        class="pl-4 py-1.5 bg-white border border-[#061131] rounded-xl w-14 text-sm text-center "
                        value="5"
                      />
                    </div>
                  </div>

                  <div class="flex items-center justify-between">
                    <div class="flex  justify-between gap-3">
                      <select class="px-4 flex-grow bg-white border font-serif  border-[#061131] rounded-2xl w-[36vw] text-sm">
                        <option>Beep 1</option>
                      </select>
                      <input
                        type="number"
                        class="pl-4 py-1.5 bg-white border font-serif  border-[#061131] rounded-xl w-14 text-sm text-center"
                        value="1"
                      />
                    </div>
                  </div>

                  <div class="flex items-center justify-between">
                    <div class="flex  justify-between gap-3">
                      <select class="px-4 flex-grow bg-white border font-serif  border-[#061131] rounded-2xl w-[36vw] text-sm">
                        <option>Beep 2</option>
                      </select>
                      <input
                        type="number"
                        class="pl-4 py-1.5 bg-white border font-serif  border-[#061131] rounded-xl w-14 text-sm text-center"
                        value="1"
                      />
                    </div>
                  </div>

                  <div class="flex items-center justify-between">
                    <div class="flex  justify-between gap-3">
                      <select class="px-4 flex-grow bg-white border font-serif  border-[#061131] rounded-2xl w-[36vw] text-sm">
                        <option>No Reminder (Muted)</option>
                      </select>
                      <input
                        type="number"
                        class="pl-4 py-1.5 bg-white border font-serif  border-[#061131] rounded-xl w-14 text-sm text-center"
                        value="5"
                      />
                    </div>
                  </div>

                  <div class="flex items-center justify-between">
                    <label class="text-md font-serif">
                      Dhikr Reminders<br />
                      <span class="text-xs font-serif no-gap block ">
                        Full screen reminders such as
                      </span>
                      <span class="text-xs font-serif block "> Surah Ak-Kahf on Fridays </span>
                    </label>
                    <div class="relative inline-block w-[8.5vw] h-6">
                      <input type="checkbox" class="sr-only peer" />
                      <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                      </div>
                    </div>
                  </div>

                  <div class="flex items-center justify-between">
                    <label class="text-md font-serif">
                      Masjid Notifications<br />
                      <span class="text-xs font-serif no-gap block ">
                        Display messages from your <br /> masjid
                      </span>
                    </label>
                    <div class="relative inline-block w-[8.5vw] h-6">
                      <input type="checkbox" class="sr-only peer" />
                      <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                      </div>
                    </div>
                  </div>

                  <div class="flex  justify-between">
                    <label class="text-md font-serif">
                      Fajr Time<br />
                      <span class="text-xs font-serif no-gap block ">
                        Adjust Fajr time in minutes
                      </span>
                    </label>
                    <div class="flex w-[9vw]">
                      <input
                        type="number"
                        class="pl-3 py-1.5 bg-white border border-[#061131] rounded-xl w-14 text-sm text-center"
                        value="1"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div :if={@active_tab == "general"} class="space-y-4 md:space-y-6">
          <div class="flex gap-2">
            <!-- Left Side -->
            <div class="flex-1 space-y-5">
              <div class="flex items-center justify-between ">
                <label class="text-sm font-medium pl-[5.5vw]">24-hr Time Format</label>
                <div class="relative inline-block w-14 h-6 pr-[10vw]">
                  <input type="checkbox" class="sr-only peer" />
                  <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                  </div>
                </div>
              </div>

              <div class="flex items-center justify-between ">
                <label class="text-sm font-medium pl-[5.5vw]">Display Weather</label>
                <div class="relative inline-block w-14 h-6 pr-[10vw]">
                  <input type="checkbox" class="sr-only peer" />
                  <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                  </div>
                </div>
              </div>

              <div class="flex items-center justify-between ">
                <label class="text-sm font-medium pl-[5.5vw]">Enable Live Streaming</label>
                <div class="relative inline-block w-14 h-6 pr-[10vw]">
                  <input type="checkbox" class="sr-only peer" />
                  <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                  </div>
                </div>
              </div>

              <div class="flex items-center justify-between ">
                <label class="text-sm font-medium pl-[5.5vw]">Night Mode</label>
                <div class="relative inline-block w-14 h-6 pr-[10vw]">
                  <input type="checkbox" class="sr-only peer" />
                  <div class="w-14 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-8 peer-checked:bg-[#1C78B7] after:content-[''] after:absolute after:top-1 after:left-1 after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all">
                  </div>
                </div>
              </div>

              <div class="flex items-center pt-4  pl-[5.5vw]">
                <svg xmlns="http://www.w3.org/2000/svg" width="60px" height="60px" viewBox="3  3 18 18"><path d="M3 9h6V3H3zm1-5h4v4H4zm1 1h2v2H5zm10 4h6V3h-6zm1-5h4v4h-4zm1 1h2v2h-2zM3 21h6v-6H3zm1-5h4v4H4zm1 1h2v2H5zm15 2h1v2h-2v-3h1zm0-3h1v1h-1zm0-1v1h-1v-1zm-10 2h1v4h-1v-4zm-4-7v2H4v-1H3v-1h3zm4-3h1v1h-1zm3-3v2h-1V3h2v1zm-3 0h1v1h-1zm10 8h1v2h-2v-1h1zm-1-2v1h-2v2h-2v-1h1v-2h3zm-7 4h-1v-1h-1v-1h2v2zm6 2h1v1h-1zm2-5v1h-1v-1zm-9 3v1h-1v-1zm6 5h1v2h-2v-2zm-3 0h1v1h-1v1h-2v-1h1v-1zm0-1v-1h2v1zm0-5h1v3h-1v1h-1v1h-1v-2h-1v-1h3v-1h-1v-1zm-9 0v1H4v-1zm12 4h-1v-1h1zm1-2h-2v-1h2zM8 10h1v1H8v1h1v2H8v-1H7v1H6v-2h1v-2zm3 0V8h3v3h-2v-1h1V9h-1v1zm0-4h1v1h-1zm-1 4h1v1h-1zm3-3V6h1v1z"/><path fill="none" d="M0 0h24v24H0z"/></svg>
                <p class="pl-2 text-sm font-serif">
                  Please scan this QR code to<br /> sync your device with  our <br />
                  Almosque  Phone application
                </p>
              </div>
            </div>
            
    <!-- Right Side -->
            <div class="flex-1 pr-[3.5vw]">
              <div class="bg-[#E4D0A8] w-[56vw]  rounded-lg ml-3 p-4">
                <div class="text-lg font-bold font-serif text-center">
                  SUPPORT SETTINGS
                </div>

                <div class="mt-2 text-lg  font-serif">
                  These settings should only be used when instructed by Almosque support.
                </div>

                <div class="mt-2">
                  <span class=" font-serif border-b-2 border-gray-800">DEVICE INFO</span>
                </div>

                <div class=" font-serif">
                  ID:24356adi031m45-9
                </div>

                <div class="mt-1  font-serif">
                  Version:21.4
                </div>

                <div class="mt-1  font-serif">
                  Last updated: 21 April 2024 08:24 PM
                </div>

                <div class="flex flex-col sm:flex-row justify-between mt-2 mb-2 px-2 gap-3">
                  <button class="bg-white rounded-lg h-10 w-32 text-center  font-serif">
                    Update App
                  </button>
                  <button class="bg-white rounded-lg h-10 w-32 text-center  font-serif">
                    Restart Device
                  </button>
                  <button class="bg-white rounded-lg h-10 w-32 text-center  font-serif">
                    Device Settings
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div class="flex mt-9">
            <!-- Left Side -->
            <div class="flex-1 pl-[5vw]">
              <div class="text-[#16529A] text-md font-serif">
                Have a question? Send us an email at info@almosque.app and we would be <br />
                happy to help you.
              </div>
            </div>
            
    <!-- Right Side -->
            <div class="flex-1">
              <div class="flex justify-center items-center gap-10 ml-3">
                <button class="w-[150px] h-[40px] border-[1px] border-[#061131] rounded-lg transition-colors ">
                  <span class="font-serif text-md whitespace-nowrap">Change Theme</span>
                </button>
                <button class="w-[150px] h-[42px] border bg-[#061131] text-white rounded-lg transition-colors ">
                  <span class="font-serif text-md whitespace-nowrap">Watch Tutorial</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end


