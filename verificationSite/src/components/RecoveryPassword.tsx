import { createSignal, onMount, createEffect, type JSX } from "solid-js";
import { createClient } from "@supabase/supabase-js";
import { ConfirmIcon } from "../icons/confirm";
import { ErrorIcon } from "../icons/error";
import { SendEmailIcon } from "../icons/sendEmail";
import type SupabaseJWT from "../types/SupabaseJWT";
import { jwtDecode } from "jwt-decode";

interface Props {
  supabaseUrl: string;
  supabaseAnonKey: string;
}

export default function RecoveryPassword(props: Props) {
  const [content, setContent] = createSignal<JSX.Element | null>(null);

  const cleanUrl = () => {
    const url = new URL(window.location.href);
    url.hash = "";
    window.history.replaceState({}, document.title, url.toString());
  };

  onMount(() => {
    const hashParams = new URLSearchParams(window.location.hash.slice(1));
    const success = hashParams.get("success");
    const token = hashParams.get("access_token");
    const error = hashParams.get("error");
    const errorCode = hashParams.get("error_code");
    const errorDesc = hashParams.get("error_description");

    if (success) {
      setContent(<VerifiedMessage />);
      return;
    }

    const supabase = createClient(props.supabaseUrl, props.supabaseAnonKey);

    if (error) {
      setContent(
        <ErrorMessage
          errorCode={errorCode}
          errorDesc={errorDesc}
          supabase={supabase}
        />
      );
      cleanUrl();
      return;
    }
    if (token) {
      const verifySession = async () => {
        const { data, error } = await supabase.auth.getSession();

        if (!data.session) {
          setContent(
            <ErrorMessage
              errorCode={"invalid_token"}
              errorDesc={"El token ha expirado o es inválido"}
              supabase={supabase}
            />
          );
          return;
        }
        const decodedToken: SupabaseJWT = jwtDecode(token);
        setContent(
          <RecoveryMessage userData={decodedToken} supabase={supabase} />
        );
      };

      verifySession().then(() => {
        cleanUrl();
        return;
      });
      return;
    }
    setContent(<WelcomeMessage />);
    cleanUrl();
  });

  return (
    <section class="w-3/4 max-w-2xl h-1/2 flex flex-col gap-7 justify-center items-center border border-black/30 rounded-2xl shadow-xl/30">
      {content()}
    </section>
  );
}

interface ErrorMessageProps {
  errorCode: string | null;
  errorDesc: string | null;
  supabase: any;
}

function ErrorMessage(props: ErrorMessageProps) {
  const [email, setEmail] = createSignal<string>();

  const resendEmail = async (event: Event) => {
    event.preventDefault();
    if (!email() || email()?.trim().length === 0) {
      alert("Ingrese un correo.");
      return;
    }
    const { error } = await props.supabase.auth.resend({
      type: "recovery",
      email,
    });
    if (error) {
      alert(
        "Error al reenviar el email. Asegurese de escribir de manera correcta su correo electronico o contacte con el administrador."
      );
    } else {
      alert("Correo de recuperación reenviado con éxito.");
    }
  };

  return (
    <>
      <ErrorIcon class="text-red-500 text-7xl" />
      <p>
        <strong>Error:</strong> {props.errorCode}
      </p>
      <p>
        {props.errorCode == "otp_expired"
          ? "Link invalido o expirado"
          : decodeURIComponent(props.errorDesc || "")}
      </p>
      <p>Solicite un reenvio de email</p>
      <form on:submit={resendEmail} class="flex items-center gap-4">
        <span class="flex flex-col items-start">
          <label>Correo:</label>
          <input
            type="email"
            class="border border-black/30 rounded p-2 outline-0 focus:border-gray-700"
            on:change={(event) => setEmail(event.target.value)}
          />
        </span>

        <button
          type="submit"
          class="flex justify-center items-center gap-4 self-end p-2 rounded-lg bg-gray-500 text-white cursor-pointer hover:bg-gray-800 transition-colors"
        >
          Reenviar
          <SendEmailIcon class="text-2xl" />
        </button>
      </form>
    </>
  );
}

interface RecoveryProps {
  userData: SupabaseJWT;
  supabase: any;
}

function RecoveryMessage({ userData, supabase }: RecoveryProps) {
  const [password, setPassword] = createSignal<string>();
  const [confirmPassword, setConfirmPassword] = createSignal<string>();

  const submitRecovery = async (event: Event) => {
    event.preventDefault();
    if (
      !password() ||
      !confirmPassword() ||
      password()?.trim().length === 0 ||
      confirmPassword()?.trim().length === 0
    ) {
      alert("Rellene todos los campos");
      return;
    }
    if ((password()?.length ?? 0) < 8 || (confirmPassword()?.length ?? 0) < 8) {
      alert("Contraseñas muy cortas");
      return;
    }
    if (password() !== confirmPassword()) {
      alert("Las contraseñas deben coincidir");
      return;
    }
    const { data, error } = await supabase.auth.updateUser({
      password: password(),
    });
    if (error) {
      alert(
        "Hubo un error. Intente con otra contraseña o comuniquese con el administrador"
      );
      return;
    }
    if (data) {
      alert("Contraseña actualizada correctamente");
      window.location.replace("/#success=true");
      return;
    }
  };

  return (
    <>
      <p class="font-bold">
        Hola {userData.user_metadata.name} {userData.user_metadata.lastname}
      </p>
      <form
        class="flex flex-col justify-center gap-4"
        on:submit={submitRecovery}
      >
        <span class="flex flex-col items-start">
          <label>Contraseña:</label>
          <input
            type="password"
            class="border border-black/30 rounded p-2 outline-0 focus:border-gray-700"
            on:change={(event) => setPassword(event.target.value)}
          />
        </span>

        <span class="flex flex-col items-start">
          <label>Confirmar contraseña:</label>
          <input
            type="password"
            class="border border-black/30 rounded p-2 outline-0 focus:border-gray-700"
            on:change={(event) => setConfirmPassword(event.target.value)}
          />
        </span>
        <button
          type="submit"
          class="flex justify-center items-center gap-4 self-center mt-4 p-2 rounded-lg bg-gray-500 text-white cursor-pointer hover:bg-gray-800 transition-colors"
        >
          Cambiar contraseña
        </button>
      </form>
    </>
  );
}

function VerifiedMessage() {
  return (
    <>
      <ConfirmIcon class="text-green-500 text-7xl" />
      <p class="font-bold">Su contraseña ha sido actualizada correctamente.</p>
      <p class="font-bold">
        Puede cerrar esta pestaña y volver a la aplicación
      </p>
    </>
  );
}

function WelcomeMessage() {
  return (
    <>
      <h1 class="ok text-5xl">Hola</h1>
    </>
  );
}
